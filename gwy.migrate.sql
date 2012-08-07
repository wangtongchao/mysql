公务员数据迁移

1. 创建 question paper 关系表

by tongchao

DROP TABLE  IF EXISTS mv_question;
CREATE TABLE `mv_question` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `o_qid` INT(10) UNSIGNED NOT NULL,
  `n_qid` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
 UNIQUE KEY `o_qid` (`o_qid`)
) ENGINE=MYISAM  DEFAULT CHARSET=utf8;

INSERT INTO platform.mv_question (o_qid,n_qid)
SELECT
c.id AS o_id,p.id AS n_id
FROM
chapter_591up.common_question c INNER JOIN platform.pt_question p
ON c.reserved = p.QuestionGuid;


DROP TABLE  IF EXISTS mv_paper;
CREATE TABLE `mv_paper` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `o_pid` INT(10) UNSIGNED NOT NULL,
  `n_pid` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
UNIQUE  KEY `o_pid` (`o_pid`)
) ENGINE=MYISAM  DEFAULT CHARSET=utf8;


INSERT INTO platform.mv_paper (o_pid,n_pid)
SELECT
  w.id AS o_id,
  p.id AS n_id
FROM
  chapter_591up.wiki_paper w
  INNER JOIN
  platform.pt_paper p
  ON w.ResourceId = p.ResourceId
WHERE w.ResourceId>'' AND w.ResourceId<>'00000000-0000-0000-0000-000000000000';



2. 创建 记录表

DROP TABLE IF EXISTS chapter_591up.move_userlog;
CREATE TABLE chapter_591up.`move_userlog` (
  `UserId` BIGINT(20) UNSIGNED NOT NULL,
  `STATUS` TINYINT(4) NOT NULL,
  `Exception` TEXT,
  `CreateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserId`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8


3. 增加索引
ALTER TABLE `chapter_591up`.`common_questionnote` ADD INDEX `idx_userid` (`UserId`);

其他
nh
sql
语句中 不能含有# 注释符号
