##公务员数据迁移==更新关系 mv question mv paper



TRUNCATE TABLE platform.mv_question ;
INSERT INTO platform.mv_question (o_qid, n_qid)
SELECT
  c.id AS o_id,
  p.id AS n_id
FROM
  chapter_591up.common_question c
  INNER JOIN
  platform.pt_question p
  ON c.reserved = p.QuestionGuid ;


TRUNCATE TABLE platform.mv_paper ;
INSERT INTO platform.mv_paper (o_pid, n_pid)
SELECT
  w.id AS o_id,
  p.id AS n_id
FROM
  chapter_591up.wiki_paper w
  INNER JOIN
  platform.pt_paper p
  ON w.ResourceId = p.ResourceId
WHERE w.ResourceId > ''
  AND w.ResourceId <> '00000000-0000-0000-0000-000000000000' ;


TRUNCATE TABLE chapter_591up.mv_paper ;
INSERT INTO chapter_591up.mv_paper
SELECT
  *
FROM
  platform.mv_paper ;


TRUNCATE TABLE chapter_591up.mv_question ;
INSERT INTO chapter_591up.mv_question
SELECT
  *
FROM
  platform.mv_question ;
