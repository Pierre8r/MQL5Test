//+------------------------------------------------------------------+
//|                                                CeaRiskReward.mqh |
//|                                   Copyright 2017, Pierre Rougier |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Pierre Rougier"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "libLogger_V_01_01.mq5"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CeaRiskReward
  {
private:
   int               m_MagicNumber;
   int               m_TakeProfitInPips;
   int               m_StopLossInPips;
   double            m_NumberOfLotsToOpen;
   datetime          m_OpenFirstOrderAtThisDateTime;
   bool              m_isOpenedOrderPreviously;

public:
                     CeaRiskReward();
                    ~CeaRiskReward();
   //--- initialization
   bool              OnInit(int MagicNumber,int exTakeProfitInPips,int exStopLossInPips,
                            double NumberOfLotsToOpen,datetime OpenFirstOrderAtThisDateTime);

   void              OnDeinit(void);
   void              OnTick(void);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CeaRiskReward::CeaRiskReward()
  {
   m_isOpenedOrderPreviously=false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CeaRiskReward::~CeaRiskReward()
  {
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Initialization and checking for input parameters                 |
//+------------------------------------------------------------------+
bool CeaRiskReward::OnInit(int MagicNumber,int TakeProfitInPips,int StopLossInPips,
                           double NumberOfLotsToOpen,datetime OpenFirstOrderAtThisDateTime)
  {
   m_MagicNumber=MagicNumber;
   m_TakeProfitInPips=TakeProfitInPips;
   m_StopLossInPips=StopLossInPips;
   m_NumberOfLotsToOpen=NumberOfLotsToOpen;
   m_OpenFirstOrderAtThisDateTime=OpenFirstOrderAtThisDateTime;

   return(true);
  }
//+------------------------------------------------------------------+
//| Deinitialization expert                                          |
//+------------------------------------------------------------------+
void CeaRiskReward::OnDeinit(void)
  {
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Deinitialization expert                                          |
//+------------------------------------------------------------------+
void CeaRiskReward::OnTick(void)
  {

//--- Define some MQL5 Structures we will use for our trade
   MqlTick last_tick;      // To be used for getting recent/latest price quotes
   MqlTradeRequest mrequest;  // To be used for sending our trade requests
   MqlTradeResult mresult;    // To be used to get our trade results
   MqlRates mrate[];          // To be used to store the prices, volumes and spread of each bar


   if(SymbolInfoTick(Symbol(),last_tick))
     {
      if(!m_isOpenedOrderPreviously)
        {
         if((last_tick.time==m_OpenFirstOrderAtThisDateTime))
           {
            Log(DEBUG,__FILE__,__FUNCTION__,__LINE__,
                " Ask :"+DoubleToString(last_tick.ask)+" Bid :"+DoubleToString(last_tick.bid)+" Time :"+TimeToString(last_tick.time));
            Log(DEBUG,__FILE__,__FUNCTION__,__LINE__,
                " Digits "+IntegerToString(_Digits)+" Point "+DoubleToString(_Point));

            ZeroMemory(mrequest);
            mrequest.action=TRADE_ACTION_DEAL;                                  // immediate order execution
            mrequest.price=NormalizeDouble(last_tick.ask,_Digits);           // latest ask price
            mrequest.sl = NormalizeDouble(last_tick.ask - m_StopLossInPips*_Point,_Digits); // Stop Loss
            mrequest.tp = NormalizeDouble(last_tick.ask+m_TakeProfitInPips*_Point,_Digits); // Take Profit
            mrequest.symbol=_Symbol;                                            // currency pair
            mrequest.volume=m_NumberOfLotsToOpen;                                                 // number of lots to trade
            mrequest.magic=m_MagicNumber;                                         // Order Magic Number
            mrequest.type = ORDER_TYPE_BUY;                                       // Buy Order
            mrequest.type_filling = ORDER_FILLING_FOK;                            // Order execution type
            mrequest.deviation=100;                                               // Deviation from current price
            //--- send order
            OrderSend(mrequest,mresult);
            // get the result code
            if(mresult.retcode==10009 || mresult.retcode==10008) //Request is completed or order placed
              {
               Log(DEBUG,__FILE__,__FUNCTION__,__LINE__,"A Buy order has been successfully placed with Ticket#:"+IntegerToString(mresult.order));
               Log(DEBUG,__FILE__,__FUNCTION__,__LINE__,
                   " Ask :"+DoubleToString(last_tick.ask)+" Bid :"+DoubleToString(last_tick.bid)+" Time :"+TimeToString(last_tick.time));
              }
            else
              {
               Log(ERROR,__FILE__,__FUNCTION__,__LINE__,"The Buy order request could not be completed - Error:"+IntegerToString(GetLastError()));
               ResetLastError();
               return;
              }
            m_isOpenedOrderPreviously=true;
           }
        }
     }
   else
     {
      Log(FATAL,__FILE__,__FUNCTION__,__LINE__,IntegerToString(GetLastError()));
     }

  }
//+------------------------------------------------------------------+
