CREATE FUNCTION CalculateTotal (@AptTimeDiff FLOAT, @BlockTime INT, @BlockCost FLOAT, @TreatmentSum FLOAT) RETURNS FLOAT AS 
BEGIN
	RETURN CONVERT(FLOAT, @TreatmentSum + (@BlockCost*CEILING(@AptTimeDiff / @BlockTime))) 
END

CREATE OR ALTER TRIGGER CreateInvoice ON Appointment
AFTER UPDATE
AS
IF ( (SELECT aptstatus
		FROM deleted) = 'C')
BEGIN
DECLARE @InvoiceNum int
SET @InvoiceNum = (SELECT InvoiceID FROM Invoice where AppointmentID = (SELECT AptID FROM deleted))
PRINT 'Invoice has already been generated for this appointment - Invoice ID: '+ CONVERT(varchar(10),@InvoiceNum)
END

ELSE IF ( (SELECT aptstatus 
      FROM   inserted) = 'C' ) 
  BEGIN 
      DECLARE @AptTimeDiff FLOAT 

      SET @AptTimeDiff = Datediff(minute, CONVERT(TIME(0), (SELECT apttime 
                                                            FROM   inserted)), 
                                            CONVERT(TIME(0), Getdate())) * 1.0 

      DECLARE @BlockTime INT 

      SET @BlockTime = (SELECT blocktd 
                        FROM   blocktime 
                        WHERE  providerid = (SELECT providerid 
                                             FROM   inserted)) 

      DECLARE @BlockCost FLOAT 

      SET @BlockCost = (SELECT blockrate 
                        FROM   blocktime 
                        WHERE  providerid = (SELECT providerid 
                                             FROM   inserted)) 

      DECLARE @TreatmentSum FLOAT 
	  
      SET @TreatmentSum = (SELECT Sum(treatmentcharge) 
                           FROM   treatmentcatalog tc 
                                  JOIN treatmentsummary ts 
                                    ON ts.tcid = tc.tcid 
                                  JOIN inserted i 
                                    ON ts.appointmentid = i.aptid)
	  IF (@TreatmentSum IS NULL)
			SET @TreatmentSum = 0;

      DECLARE @InvoiceTotal FLOAT 

      SET @InvoiceTotal = dbo.Calculatetotal(@AptTimeDiff, @BlockTime, 
                          @BlockCost, 
                          @TreatmentSum) 

      INSERT INTO invoice 
                  (totalamount, 
                   appointmentid) 
      VALUES      ( @InvoiceTotal, 
                    (SELECT aptid 
                     FROM   inserted) ) 

      PRINT 'Invoice Created' 
  END

----------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Appointment VALUES (18, '2019-12-13', '19:00:00', 'O', 'Oral Cancer', 1, 5, 1)
SELECT * FROM Appointment

UPDATE Appointment SET AptStatus='C' WHERE AptID=18
SELECT * FROM Invoice