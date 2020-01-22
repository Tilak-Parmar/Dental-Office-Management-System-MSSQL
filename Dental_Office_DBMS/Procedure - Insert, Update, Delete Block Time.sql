--Procedure to Insert/Update/Delete/Select


CREATE or ALTER PROC BlockTimeProc(
@BlockID int,
@BlockTD int,
@BlockRate money,
@ProviderID int,
@StatementType nvarchar(20) = ''
)
AS
BEGIN
IF @StatementType = 'Insert'
BEGIN
INSERT INTO BlockTime VALUES (@BlockID, @BlockTD, @BlockRate, @ProviderID)
END
IF @StatementType = 'Select'
BEGIN
SELECT * FROM BlockTime
END
IF @StatementType = 'Update'  
BEGIN  
UPDATE BlockTime SET  
 BlockTD= @BlockTD, ProviderID = @ProviderID,  
BlockRate = @BlockRate  
WHERE BlockID = @BlockID
END  
ELSE IF @StatementType = 'Delete'  
BEGIN  
DELETE FROM BlockTime WHERE BlockID = @BlockID
END
END

EXEC BlockTimeProc 200, 10, 15, 11, 'Insert'
SELECT * FROM BlockTime

EXEC BlockTimeProc 200, 20, 26, 11, 'Update'
SELECT * FROM BlockTime