{-# LANGUAGE OverloadedStrings #-}

module Graphics.NVD3.Charts where

import           Data.Aeson
import           Data.Text.Lazy                  (Text)
import qualified Data.Text.Lazy                  as T
import qualified Data.Text.Lazy.Builder     as B
import qualified Data.Text.Lazy.Builder.Int as B
import           Data.Vector                (Vector)
import qualified Data.Vector                as V

import           Graphics.NVD3.Types
import           Graphics.NVD3.Writer


line :: [Series] -> ChartOptions -> Text
line ss options = if null ss
                  then ""
                  else B.toLazyText $ buildJS "lineChart" ss options

scatter :: [Series] -> ChartOptions -> Text
scatter ss options = if null ss
                     then ""
                     else B.toLazyText $ buildJS "scatterChart" ss options

stackedArea :: [Series] -> ChartOptions -> Text
stackedArea ss options = if null ss
                         then ""
                         else B.toLazyText $ buildJS "stackedAreaChart" ss options

bar :: [Series] -> ChartOptions -> Text
bar ss options = if null ss
                 then ""
                 else B.toLazyText $ buildJS "discreteBarChart" ss options

multiBar :: [Series] -> ChartOptions -> Text
multiBar ss options = if null ss
                      then ""
                      else B.toLazyText $ buildJS "multiBarChart" ss options

multiBarH :: [Series] -> ChartOptions -> Text
multiBarH ss options = if null ss
                       then ""
                       else B.toLazyText $ buildJS "multiBarChartHorizontalChart" ss options

lineBar :: [Series] -> ChartOptions -> Text
lineBar ss options = if null ss
                     then ""
                     else B.toLazyText $ buildJS "linePlusBarChart" ss options

cumLine :: [Series] -> ChartOptions -> Text
cumLine ss options = if null ss
                     then ""
                     else B.toLazyText $ buildJS "cumulativeLineChart" ss options
                            
lineFocus :: [Series] -> ChartOptions -> Text
lineFocus ss options = if null ss
                       then ""
                       else B.toLazyText $ buildJS "lineWithFocusChart" ss options

pie :: [Series] -> ChartOptions -> Text
pie ss options = if null ss
                 then ""
                 else B.toLazyText $ buildJS "pieChart" ss options

-- bullet :: [Series] -> ChartOptions -> Text
-- bullet ss options = if null ss
--                     then ""
--                     else B.toLazyText $ buildJS "bulletChart" ss options

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--- tests

-- line chart

s1 = defSeries
s2 = defSeries {values = mkNumVals (V.enumFromN 1 20) (V.map (*3) $ V.enumFromN 1 20), key = "Second Series"}

-- d1 = defSeries {values = V.fromList["Group 1", "Group 2", "Group 3", "Group 4", "Group 5"]}
-- d2 = defSeries {values = , key = "Second Series"}

d1 = undefined
d2 = undefined

testLine = line [s1, s2] defChartOptions {useInteractiveGuideline = Just True, cssSelector = "#lineChart svg"}

-- scatter plot

testScatter = scatter [s1 {size = Just 0.45}, s2 {size = Just 0.9}] defChartOptions {useInteractiveGuideline = Just True, cssSelector = "#scatterChart svg"}

-- stacked area

testStackedArea = stackedArea [s1, s2] defChartOptions {useInteractiveGuideline = Just True, cssSelector = "#stackedAreaChart svg"}

-- bar chart

testBar = bar [d1] defChartOptions {useInteractiveGuideline = Just True, showValues = Just True, cssSelector = "#barChart svg"}

-- multi-bar chart

testMultiBar = multiBar [d1, d2] defChartOptions {useInteractiveGuideline = Just True, reduceXTicks = Just True, cssSelector = "#multiBarChart svg", groupSpacing = Just 0.1}

-- horizontal multi-bar chart

testMultiBarH = multiBarH [d1, d2] defChartOptions {useInteractiveGuideline = Just True, cssSelector = "#multiBarHChart svg", showValues = Just True, margins = Just defMargins}

-- line plus bar chart

testLineBar = lineBar [d1,s2] defChartOptions {useInteractiveGuideline = Just True, cssSelector = "#lineBarChart svg", margins = Just defMargins}

-- cumulative line chart

testCumLine = cumLine [s1,s2] defChartOptions {useInteractiveGuideline = Just True, cssSelector = "#cumLineChart svg"}

-- line chart with focus

testLineFocus = lineFocus [s1,s2] defChartOptions {cssSelector = "#lineFocusChart svg"}

-- pie chart

testPieChart = pie [s1,s2] defChartOptions {cssSelector = "#pieChart svg", showLabels = Just True, labelType = Just LabelPercent}

testDonutChart = pie [s1,s2] defChartOptions {cssSelector = "#donutChart svg", showLabels = Just True, donut = Just True, donutRatio = Just 0.35}

-- bullet chart

-- testBullet
