CREATE OR ALTER FUNCTION dbo.getProviderTotalIncome(@ProviderID INT)
RETURNS MONEY AS 
BEGIN
DECLARE @total MONEY
SELECT @total = ( 
                  SELECT   Sum(totalamount) 
                  FROM     invoice 
                  JOIN     appointment 
                  ON       appointment.aptid = invoice.appointmentid 
                  WHERE    providerid = @ProviderID 
                  GROUP BY ProviderID)
RETURN @total 
END

CREATE OR ALTER FUNCTION dbo.getPatientTotalPayableAmount(@PatientID INT) 
RETURNS MONEY AS 
BEGIN
DECLARE @total MONEY
SELECT @total = ( 
                  SELECT   Sum(totalamount) 
                  FROM     invoice 
                  JOIN     appointment 
                  ON       appointment.aptid = invoice.appointmentid 
                  WHERE    patientid = @PatientID 
                  GROUP BY patientid)
RETURN @total 
END

--------------------------------------------------------------------------------------------
SELECT ProviderID, ProviderFN+' '+ProviderLN AS DentistName, dbo.getProviderTotalIncome(ProviderID) AS ProviderTotalIncome FROM [Provider]
SELECT PatientID, PatientFN, dbo.getPatientTotalPayableAmount(PatientID) AS PatientPaidTotal FROM Patient

SELECT * FROM Appointment
SELECT * FROM Invoice