/*
  GIVEN THE CURRENT DATE AND TIME LAPSE, QUERY THE START AND END DATE FOR PREVIOUS MONTH, WEEK OR TWO WEEKS.
*/

DECLARE @currentDate DATETIME = GETDATE();
DECLARE @timeLapse VARCHAR(10) = 'MONTHLY';

SELECT 
  CASE 
   WHEN @timeLapse = 'MONTHLY' THEN CONVERT(VARCHAR, DATEADD(d,-(DAY(DATEADD(m,-1,@currentDate-2))),DATEADD(m,-1,@currentDate-1)),23)
   WHEN @timeLapse = 'BIWEEKLY' AND DAY(@currentDate) > 15 THEN CONVERT(VARCHAR, DATEADD(d,-(DAY(@currentDate-2)),@currentDate-1),23)
   WHEN @timeLapse = 'BIWEEKLY' AND DAY(@currentDate) <= 15 THEN CONVERT(VARCHAR, DATEADD(d,16-DATEPART(d,@currentDate),DATEADD(m,-1,@currentDate)),23)
   WHEN @timeLapse = 'WEEKLY' THEN CONVERT(VARCHAR, DATEADD(wk, -1, DATEADD(DAY, 1-DATEPART(WEEKDAY, @currentDate), DATEDIFF(dd, 0, @currentDate))),23)
   END AS StartDate,
   CASE 
   WHEN @timeLapse = 'MONTHLY' THEN CONVERT(VARCHAR, DATEADD(d,-(DAY(@currentDate)),@currentDate),23)
   WHEN @timeLapse = 'BIWEEKLY' AND DAY(@currentDate) > 15 THEN CONVERT(VARCHAR,DATEADD(d,15,DATEADD(d,-(DAY(@currentDate)),@currentDate)),23)
   WHEN @timeLapse = 'BIWEEKLY' AND DAY(@currentDate) <= 15 THEN CONVERT(VARCHAR,DATEADD(d,-(DAY(@currentDate)),@currentDate),23)
   WHEN @timeLapse = 'WEEKLY' THEN CONVERT(VARCHAR, DATEADD(wk, 0, DATEADD(DAY, 0-DATEPART(WEEKDAY, @currentDate), DATEDIFF(dd, 0, @currentDate))),23)
   END AS EndDate