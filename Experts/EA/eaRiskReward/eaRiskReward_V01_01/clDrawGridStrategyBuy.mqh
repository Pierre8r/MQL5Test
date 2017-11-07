//+------------------------------------------------------------------+
//|                                       clDrawGridStrategyBuy.mqh |
//|                                         Copyright 2014, Pierre8r |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Pierre8r"
#property link      "http://www.mql4.com"
#property version   "1.00"
#property strict

#include "libLogger_V_01_01.mq4"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CDrawGridStrategyBuy
  {
private:
   double            m_Target;
   double            m_StopLoss;
   int               m_NumberOfLevels;
   double            m_NeutralizedArea;
   int               m_HighestLevelDrawn;
   int               m_LowestLevelDrawn;

   double            m_HeightOfLevel;

public:
                     CDrawGridStrategyBuy(double BuyTarget,double BuyStopLoss,int BuyNumberOfLevels,
                                                            double NeutralizedArea,int BuyHighestLevelDrawn,int BuyLevelLowest);
                    ~CDrawGridStrategyBuy();

   void              OnTick();

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CDrawGridStrategyBuy::CDrawGridStrategyBuy(double BuyTarget,double BuyStopLoss,int BuyNumberOfLevels,double NeutralizedArea,int BuyHighestLevelDrawn,int BuyLowestLevelDrawn):
m_Target(BuyTarget),m_StopLoss(BuyStopLoss),m_NumberOfLevels(BuyNumberOfLevels),m_HighestLevelDrawn(BuyHighestLevelDrawn),m_LowestLevelDrawn(BuyLowestLevelDrawn)
  {
   m_HeightOfLevel=(m_Target-m_StopLoss)/m_NumberOfLevels;
   double price=m_Target+(m_HeightOfLevel*(-m_LowestLevelDrawn));
   string  ParalelOjectName;
   string  LevelOjectName;

   for(int i=m_LowestLevelDrawn;i<m_HighestLevelDrawn+1;i++)
     {
      ParalelOjectName="Buy_Paralel"+IntegerToString(i);
      LevelOjectName="Buy_Level"+IntegerToString(i);

      if(!ObjectCreate(0,ParalelOjectName,OBJ_HLINE,0,0,price))
        {
         Log(ERROR,__FILE__,__FUNCTION__,__LINE__,StringConcatenate("Failed to create a horizontal line. Error code :",GetLastError()));
        }
      if(!ObjectSet(ParalelOjectName,OBJPROP_COLOR,clrYellow))
        {
         Log(ERROR,__FILE__,__FUNCTION__,__LINE__,StringConcatenate("Failed to set color. Error code :",GetLastError()));
        }

      if(!ObjectCreate(0,LevelOjectName,OBJ_TEXT,0,0,price))
        {
         Log(ERROR,__FILE__,__FUNCTION__,__LINE__,StringConcatenate("Failed to create a OBJ_TEXT. Error code :",GetLastError()));
        }
      if(!ObjectSetString(0,LevelOjectName,OBJPROP_TEXT,LevelOjectName))
        {
         Log(ERROR,__FILE__,__FUNCTION__,__LINE__,StringConcatenate("Failed to create a OBJPROP_TEXT. Error code :",GetLastError()));
        }


      price=price-m_HeightOfLevel;
     }

   if(!ObjectCreate(0,"Buy_StopLoss",OBJ_HLINE,0,0,m_StopLoss))
     {
         Log(ERROR,__FILE__,__FUNCTION__,__LINE__,StringConcatenate("Failed to create a horizontal line. Error code :",GetLastError()));
     }
   if(!ObjectSet("Buy_StopLoss",OBJPROP_COLOR,clrRed))
     {
      Log(ERROR,__FILE__,__FUNCTION__,__LINE__,StringConcatenate("Failed to set a color. Error code :",GetLastError()));
     }
   if(!ObjectCreate(0,"Buy_Target",OBJ_HLINE,0,0,m_Target))
     {
         Log(ERROR,__FILE__,__FUNCTION__,__LINE__,StringConcatenate("Failed to create a horizontal line. Error code :",GetLastError()));
     }
   if(!ObjectSet("Buy_Target",OBJPROP_COLOR,clrGreen))
     {
      Log(ERROR,__FILE__,__FUNCTION__,__LINE__,StringConcatenate("Failed to set a color. Error code :",GetLastError()));
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CDrawGridStrategyBuy::~CDrawGridStrategyBuy()
  {
  }
//+------------------------------------------------------------------+
void CDrawGridStrategyBuy::OnTick()
  {
   string  ParalelOjectName;
   string  LevelOjectName;

   for(int i=m_LowestLevelDrawn;i<m_HighestLevelDrawn+1;i++)
     {
      ParalelOjectName="Buy_Paralel"+IntegerToString(i);
      LevelOjectName="Buy_Level"+IntegerToString(i);
      if(!ObjectMove(LevelOjectName,0,Time[0],ObjectGet(ParalelOjectName,OBJPROP_PRICE1)))
        {
         Log(ERROR,__FILE__,__FUNCTION__,__LINE__,StringConcatenate("Failed to move Text. Error code :",GetLastError()));
        }
     }
  }
//+------------------------------------------------------------------+
