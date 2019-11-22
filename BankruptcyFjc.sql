-- FJC Bankruptcy Experiment
--  https://www.fjc.gov/research/idb/bankruptcy-cases-filed-terminated-and-pending-fy-2008-present

-- Create the Import table
CREATE TABLE [dbo].[FjcBankruptcyImport](
               [SNAPSHOT] [date] NULL,
               [SNAPFILE] [varchar](1) NULL,
               [SNAPPEND] [varchar](1) NULL,
               [SNAPCLOS] [varchar](1) NULL,
               [CASEKEY] [varchar](20) NULL,
               [CIRCUIT] [varchar](2) NULL,
               [DISTRICT] [varchar](2) NULL,
               [OFFICE] [varchar](1) NULL,
               [DOCKET] [varchar](7) NULL,
               [GEN] [varchar](1) NULL,
               [SEQ] [varchar](1) NULL,
               [ORIGIN] [varchar](1) NULL,
               [ORGFLDT] [date] NULL,
               [FILEDATE] [date] NULL,
               [FILECY] [int] NULL,
               [FILEFY] [int] NULL,
               [ORGFLCHP] [varchar](3) NULL,
               [CRNTCHP] [varchar](3) NULL,
               [ORGNTRDBT] [varchar](1) NULL,
               [NTRDBT] [varchar](1) NULL,
               [JOINT] [varchar](1) NULL,
               [D1ZIP] [varchar](15) NULL,
               [D1CNTY] [varchar](5) NULL,
               [ORGD1FPRSE] [varchar](1) NULL,
               [D1FPRSE] [varchar](1) NULL,
               [D1CHGDT] [date] NULL,
               [D2ZIP] [varchar](15) NULL,
               [D2CNTY] [varchar](5) NULL,
               [ORGD2FPRSE] [varchar](1) NULL,
               [D2FPRSE] [varchar](1) NULL,
               [D2CHGDT] [date] NULL,
               [ORGFEESTS] [varchar](1) NULL,
               [FEESTS] [varchar](1) NULL,
               [CASETYP] [varchar](1) NULL,
               [ORGDBTRTYP] [varchar](1) NULL,
               [DBTRTYP] [varchar](1) NULL,
               [NOB] [varchar](1) NULL,
               [PRFILE] [varchar](1) NULL,
               [ORGEASST] [varchar](1) NULL,
               [EASST] [varchar](1) NULL,
               [ORGELBLTS] [varchar](1) NULL,
               [ELBLTS] [varchar](1) NULL,
               [ORGECRDTRS] [varchar](1) NULL,
               [ECRDTRS] [varchar](1) NULL,
               [ORGASSTCASE] [varchar](1) NULL,
               [ASSTCASE] [varchar](1) NULL,
               [SMLLBUS] [varchar](1) NULL,
               [PREPACK] [varchar](1) NULL,
               [TOTASSTS] [varchar](12) NULL,
               [REALPROP] [varchar](12) NULL,
               [PERSPROP] [varchar](12) NULL,
               [TOTLBLTS] [varchar](12) NULL,
               [SECURED] [varchar](12) NULL,
               [UNSECPR] [varchar](12) NULL,
               [UNSECNPR] [varchar](12) NULL,
               [DSCHRGD] [varchar](12) NULL,
               [NDSCHRGD] [varchar](12) NULL,
               [TOTDBT] [varchar](12) NULL,
               [CNTMNTHI] [varchar](12) NULL,
               [AVGMNTHI] [varchar](12) NULL,
               [AVGMNTHE] [varchar](12) NULL,
               [SRCCASE] [varchar](20) NULL,
               [DSTNCASE] [varchar](20) NULL,
               [CNSLLEAD] [varchar](20) NULL,
               [JNTLEAD] [varchar](20) NULL,
               [FLCMECFV] [varchar](20) NULL,
               [CLOSEDT] [date] NULL,
               [CLOSECY] [int] NULL,
               [CLOSEFY] [int] NULL,
               [CLCHPT] [varchar](3) NULL,
               [D1CPRSE] [varchar](1) NULL,
               [D1FDSP] [varchar](1) NULL,
               [D1FDSPDT] [date] NULL,
               [D1FDSPCY] [int] NULL,
               [D1FDSPFY] [int] NULL,
               [D2CPRSE] [varchar](1) NULL,
               [D2FDSP] [varchar](1) NULL,
               [D2FDSPDT] [date] NULL,
               [D2FDSPCY] [int] NULL,
               [D2FDSPFY] [int] NULL,
               [C11DVDND] [varchar](3) NULL,
               [C11FTRPAY] [varchar](1) NULL,
               [CLCMECFV] [varchar](20) NULL,
               [TAXEXEMPT] [varchar](1) NULL
) ON [PRIMARY]
GO


-- Create the Import table indexes

CREATE INDEX ix_bankruptcy_ntrdbt
ON FjcBankruptcyImport(NTRDBT);

CREATE INDEX ix_bankruptcy_snapclos
ON FjcBankruptcyImport(SNAPCLOS);

CREATE INDEX ix_bankruptcy_orgflchp
ON FjcBankruptcyImport(ORGFLCHP);


-- Initial filter of Business, Chapter 11, Closed case rows
-- Minor type conversions

SELECT  
	SNAPSHOT,
	CASEKEY,
	CIRCUIT,
	DISTRICT,
	OFFICE,
	DOCKET,
	GEN,
	SEQ,
	ORIGIN,
	FILECY,
	ORGFLCHP,
	CRNTCHP,
	ORGNTRDBT,
	NTRDBT,
	JOINT,
	D1ZIP,
	D1CNTY,
	ORGD1FPRSE,
	D1FPRSE,
	D2ZIP,
	D2CNTY,
	ORGD2FPRSE,
	D2FPRSE,
	ORGFEESTS,
	FEESTS,
	CASETYP,
	ORGDBTRTYP,
	DBTRTYP,
	NOB,
	PRFILE,
	ORGEASST,
	EASST,
	ORGELBLTS,
	ELBLTS,
	ORGECRDTRS,
	ECRDTRS,
	ORGASSTCASE,
	ASSTCASE,
	SMLLBUS,
	PREPACK,
	CAST(TOTASSTS AS decimal) AS TOTASSTS,
	CAST(REALPROP AS decimal) AS REALPROP,
	CAST(PERSPROP AS decimal) AS PERSPROP,
	CAST(TOTLBLTS AS decimal) AS TOTLBLTS,
	CAST(SECURED AS decimal) AS SECURED,
	CAST(UNSECPR AS decimal) AS UNSECPR,
	CAST(UNSECNPR AS decimal) AS UNSECNPR,
	CAST(DSCHRGD AS decimal) AS DSCHRGD,
	CAST(NDSCHRGD AS decimal) AS NDSCHRGD,
	CAST(TOTDBT AS decimal) AS TOTDBT,
	CAST(CNTMNTHI AS decimal) AS CNTMNTHI,
	CAST(AVGMNTHI AS decimal) AS AVGMNTHI,
	CAST(AVGMNTHE AS decimal) AS AVGMNTHE,
	CASE WHEN SRCCASE is not null THEN 1 ELSE 0 END AS SRCCASE,
	CASE WHEN DSTNCASE is not null THEN 1 ELSE 0 END AS DSTNCASE,
	CASE WHEN CNSLLEAD is not null THEN 1 ELSE 0 END AS CNSLLEAD,
	CASE WHEN JNTLEAD is not null THEN 1 ELSE 0 END AS JNTLEAD,
	CASE WHEN FLCMECFV is not null THEN 1 ELSE 0 END AS FLCMECFV,
	CLOSECY,
	CLCHPT,
	D1CPRSE,
	D1FDSP,
	D1FDSPCY,
	D2CPRSE,
	D2FDSP,
	D2FDSPCY,
	CAST(C11DVDND AS float) AS C11DVDND,
	C11FTRPAY,
	TAXEXEMPT
INTO FjcBankruptcy
FROM FjcBankruptcyImport
WHERE NTRDBT='b'
	AND SNAPCLOS='1'
	AND ORGFLCHP='11'


-- Create Feature Engineering table
SELECT
	CASEKEY,
	CIRCUIT,
	DISTRICT,
	OFFICE,
	FILECY,
	ORGFLCHP,
	ORGNTRDBT,
	JOINT,
	D1CNTY,
	CASETYP,
	DBTRTYP,
	NOB,
	CASE WHEN PRFILE = 'y' THEN 1 ELSE 0 END AS PRFILE,
	ORGEASST,
	ORGELBLTS,
	ORGECRDTRS,
	TOTASSTS,
	TOTLBLTS,
	TOTDBT,
	CASE
		WHEN TOTLBLTS > 0 THEN TOTASSTS / TOTLBLTS 
		ELSE 0
	END AS TotalAssetsToLiabilities,
	CASE
		WHEN TOTLBLTS > 0 THEN SECURED / TOTLBLTS 
		ELSE 0
	END AS SecuredLiabilityPercent,
	CASE 
		WHEN TOTDBT > 0 THEN DSCHRGD / TOTDBT
		ELSE 0
		END AS DebtDischargedPct,
	JNTLEAD,
	FLCMECFV,
	CASE WHEN ORGD1FPRSE = 'y' THEN 1 ELSE 0 END AS ORGD1FPRSE,
	CASE 
		WHEN D1FDSP IN ('H', 'I', 'J', 'K', 'T', 'U') AND ORGFLCHP = CRNTCHP THEN 'D'
		WHEN ORGFLCHP <> CRNTCHP THEN 'C'
		ELSE 'V' END AS Outcome
INTO FjcBankruptcyFeatures
FROM FjcBankruptcy
WHERE (ORGECRDTRS IS NOT NULL AND ORGELBLTS IS NOT NULL AND ORGEASST IS NOT NULL AND NOB IS NOT NULL)


