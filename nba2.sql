
#插入
INSERT INTO team VALUES(NULL,"马刺",10,100,90,5,"AT&T中心");
INSERT INTO team VALUES(NULL,"勇士",10,100,90,5,"甲骨文中心");
INSERT INTO team(teamId,teamName,teamAge,toalMatch,victoryNumber,championNumber) VALUES(NULL,"凯尔特人",10,100,89,4);
INSERT INTO team(teamId,teamName,teamAge,toalMatch,victoryNumber,championNumber) VALUES(NULL,"火箭",10,100,90,5);
#批量插入
INSERT INTO team(teamId,teamName,teamAge,toalMatch,victoryNumber,championNumber) VALUES(NULL,"老鹰",10,100,90,5),(NULL,"黄蜂",10,100,90,5),(NULL,"鹈鹕",10,100,90,5);
INSERT INTO team VALUES(NULL,"公牛",10,100,90,5,"联合中心"),(NULL,"骑士",10,100,90,5,"速贷球馆"),(NULL,"灰熊",10,100,90,5,"联邦快递球馆");
#插入教练表
INSERT INTO coach(coachId,coachName,championNumber,teamId) VALUES(NULL,"波波维奇",5,(SELECT teamId FROM team WHERE team.`teamName`='马刺'));
INSERT INTO coach(coachId,coachName,championNumber,teamId) VALUES(NULL,"史蒂文斯",0,(SELECT teamId FROM team WHERE team.`teamName`='凯尔特人'));

#模糊删除
DELETE FROM team WHERE team.`teamName` LIKE '马刺%'


#查询全部
SELECT * FROM team;
SELECT * FROM coach;

#条件查询
SELECT teamId FROM team WHERE team.`teamName`='马刺'


#删除表
DROP TABLE team ;
DROP TABLE coach ;
DROP TABLE test;