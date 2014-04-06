
SELECT NOW() AS starting_datetime, "Check season vs career stats", COUNT(*) AS n_bat from batting;

-- SELECT bw.`lahmanID`, bw.`playerID`, bw.`yearID`, bw.lgID, bat.`lgID`, bw.PA, bw.G, bat.G, (100 + bat.G - bw.G) AS diffG, bw.`isPitcher`
--   FROM `bat_war` bw
--   LEFT JOIN batting bat ON (bw.`playerID` = bat.`playerID`) AND (bw.`yearID` = bat.`yearID`) AND (bw.`stint` = bat.`stint`)
--   WHERE (bw.PA > 0) AND (bat.G != bw.G)
--   ORDER BY playerID, yearID DESC
--   ;

-- SELECT playerID, 'all' AS yearID,
--     G, G_batting, PA, AB, BB, HBP, SH, SF, CIB
--   FROM `bat_career` batc
--   WHERE (batc.CIB < 0)
--   ORDER BY playerID DESC
--   ;


SELECT playerID, yearID,
    G, G_batting, PA, AB, BB, HBP, SH, SF, CIB
  FROM `bat_season` bats
  WHERE (bats.CIB < 0) -- AND playerID LIKE "mcnaier01"
  ORDER BY yearID, playerID DESC
  ;

SELECT playerID, yearID,
    G, G_batting, PA, AB, BB, HBP, SH, SF, CIB
  FROM `batting` bats
  WHERE playerID LIKE "phillan01"
  ORDER BY yearID, playerID DESC
  ;


SELECT NOW() AS starting_datetime, "Check season vs career stats", COUNT(*) AS n_bat from batting;

SELECT cbat.playerID,
  cbat.G,
  cbat.G    - sbat.G      AS Gdiff,
  cbat.R    - sbat.R      AS Rdiff,     cbat.H   - sbat.H   AS Hdiff,
  cbat.2B   - sbat.2B     AS 2Bdiff,    cbat.3B  - sbat.3B  AS 3Bdiff,
  cbat.HR   - sbat.HR     AS HRdiff,    cbat.RBI - sbat.RBI AS RBIdiff,
  cbat.SB   - sbat.SB     AS SBdiff,    cbat.CS  - sbat.CS  AS CSdiff,
  cbat.BB   - sbat.BB     AS BBdiff,    cbat.SO  - sbat.SO  AS SOdiff,
  cbat.IBB  - sbat.IBB    AS IBBdiff,   cbat.HBP - sbat.HBP AS HBPdiff,
  cbat.SH   - sbat.SH     AS SHdiff,    cbat.SF  - sbat.SF  AS SFdiff,
  cbat.GIDP - sbat.GIDP   AS GIDPdiff,
  cbat.years - sbat.years AS yearsdiff
  FROM `bat_career` cbat
  LEFT JOIN (
    SELECT playerID,
    SUM(G) AS G,
    SUM(`PA`) AS `PA`, SUM(`AB`) AS `AB`, SUM(`R`) AS `R`, SUM(`H`) AS `H`, SUM(`2B`) AS `2B`, SUM(`3B`) AS `3B`, SUM(`HR`) AS `HR`,
    SUM(`RBI`) AS `RBI`, SUM(`SB`) AS `SB`, SUM(`CS`) AS `CS`, SUM(`BB`) AS `BB`, SUM(`SO`) AS `SO`, SUM(`IBB`) AS `IBB`,
    SUM(`HBP`) AS `HBP`, SUM(`SH`) AS `SH`, SUM(`SF`) AS `SF`, SUM(`GIDP`) AS `GIDP`,
    COUNT(*) AS years
    FROM `bat_season` GROUP BY `playerID`
    ) sbat
    ON cbat.`playerID` = sbat.`playerID`
  HAVING
    ABS(Gdiff) > 0 OR ABS(Rdiff) > 0 OR ABS(2Bdiff) > 0 OR ABS(HRdiff) > 0 OR ABS(SBdiff) > 0 OR ABS(BBdiff) > 0 OR ABS(IBBdiff) > 0 OR ABS(SHdiff) > 0 OR ABS(GIDPdiff) > 0 OR ABS(yearsdiff) > 0 OR ABS(Hdiff) > 0 OR ABS(3Bdiff) > 0 OR ABS(RBIdiff) > 0 OR ABS(CSdiff) > 0 OR ABS(SOdiff) > 0 OR ABS(HBPdiff) > 0 OR ABS(SFdiff) > 0
  ;
