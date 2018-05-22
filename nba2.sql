 
#插入 
#如果是自增的，可以设置为null或者default来实现自增
#默认值的情况  可以直接写默认值，也可以写default
#对于一些数字，可以写数学表达式进去  
INSERT INTO team VALUES(NULL,"马刺",10,100*2-100,90,5,"AT&T中心");
INSERT INTO team VALUES(DEFAULT,"勇士",10,100,90,DEFAULT,"甲骨文中心");
INSERT INTO team(teamId,teamName,teamAge,toalMatch,victoryNumber,championNumber) VALUES(NULL,"凯尔特人",10,100,89,4);
INSERT INTO team(teamId,teamName,teamAge,toalMatch,victoryNumber,championNumber) VALUES(NULL,"火箭",10,100,90,5);
INSERT team SET teamName="开拓者",teamAge=10,toalMatch=100,victoryNumber=90,championNumber=2,ballHall="玫瑰花园球馆";

INSERT INTO test VALUES (NULL,"小米1",1),(NULL,"小米2",2),(NULL,"小米3",3),(NULL,"小米4",4),(NULL,"小米5",5);

INSERT test SELECT *FROM test LIMIT 2;

#批量插入
INSERT INTO team(teamId,teamName,teamAge,toalMatch,victoryNumber,championNumber) VALUES(NULL,"老鹰",10,100,90,5),(NULL,"黄蜂",10,100,90,5),(NULL,"鹈鹕",10,100,90,5);
INSERT INTO team VALUES(NULL,"公牛",10,100,90,5,"联合中心"),(NULL,"骑士",10,100,90,5,"速贷球馆"),(NULL,"灰熊",10,100,90,5,"联邦快递球馆");
#插入教练表
INSERT INTO coach(coachId,coachName,championNumber,teamId) VALUES(NULL,"波波维奇",5,(SELECT teamId FROM team WHERE team.`teamName`='马刺'));
INSERT INTO coach(coachId,coachName,championNumber,teamId) VALUES(NULL,"史蒂文斯",0,(SELECT teamId FROM team WHERE team.`teamName`='凯尔特人'));

#修改记录(单表更新)
UPDATE team SET teamAge=teamAge+10,championNumber=championNumber+1 WHERE teamName="马刺";
#删除(单表删除)
DELETE FROM team WHERE team.`teamName` = '马刺'

#查询全部
SELECT * FROM team
#再把删除的那个记录插入进去
INSERT INTO team VALUES(NULL,"马刺",10,100*2-100,90,5,"AT&T中心");
#查询某些列
SELECT team.ballHall,team.teamName,championNumber FROM team
#查询设置别名 这个地方的as可以省略，但是不建议省略避免出现误会
SELECT team.`ballHall`AS BallHall,team.`teamName` AS tName,team.`championNumber` AS tNumber FROM team;
#简单条件查询
SELECT * FROM team WHERE team.`teamName`='马刺'
#分组查询  
SELECT * FROM team GROUP BY championNumber DESC 

#HAVING关键字  两个条件必须满足其一  
#1:having后边的字段必须在结果集中 
SELECT * FROM team GROUP BY championNumber HAVING championNumber>3 
#2:having后边是个函数
SELECT * FROM team GROUP BY championNumber HAVING SUM(championNumber)>3 


#排序
#按总冠军的数量排序
SELECT *FROM team ORDER BY championNumber DESC
#总冠军数量相同的 按胜利场次多的排序
SELECT *FROM team ORDER BY championNumber DESC,victoryNumber DESC
#总冠军数量相同的、胜利场次相同，按id小的排序
SELECT *FROM team ORDER BY championNumber DESC,victoryNumber DESC,teamId ASC

#限制查询数量 
#查询前2条
SELECT *FROM team LIMIT 2;
#查询从第4个开始，查询2条
SELECT *FROM team LIMIT 3,2;


#列出不重复的
SELECT DISTINCT * FROM team


#================================================================子查询=========================================================
#先补充数据(球队信息)
UPDATE team SET ballHall="甲骨文体育馆"  ,teamAge=2018-1946,toalMatch=82,victoryNumber=58,championNumber=2 WHERE teamName="勇士";
UPDATE team SET ballHall="TD花园" ,teamAge=2018-1946,toalMatch=82,victoryNumber=55,championNumber=17 WHERE teamName="凯尔特人";
UPDATE team SET ballHall="丰田中心" ,teamAge=2018-1967,toalMatch=82,victoryNumber=65,championNumber=2   WHERE teamName="火箭";
UPDATE team SET ballHall="菲利普斯球馆"  ,teamAge=2018-1949,toalMatch=82,victoryNumber=24,championNumber=1   WHERE teamName="老鹰";
UPDATE team SET ballHall="时代华纳有线球馆" ,teamAge=2018-2004,toalMatch=82,victoryNumber=36,championNumber=0   WHERE teamName="黄蜂";
UPDATE team SET ballHall="冰沙国王中心"  ,teamAge=2018-1988,toalMatch=82,victoryNumber=48,championNumber=0 WHERE teamName="鹈鹕";
UPDATE team SET ballHall="联合中心球馆"   ,teamAge=2018-1966,toalMatch=82,victoryNumber=27,championNumber=6 WHERE teamName="公牛";
UPDATE team SET ballHall="速贷球馆" ,teamAge=2018-1970,toalMatch=82,victoryNumber=50,championNumber=1  WHERE teamName="骑士";
UPDATE team SET ballHall="联邦快递体育馆"  ,teamAge=2018-1995,toalMatch=82,victoryNumber=22,championNumber=0  WHERE teamName="灰熊";
UPDATE team SET ballHall="摩达中心"  ,teamAge=2018-1970,toalMatch=82,victoryNumber=49,championNumber=1 WHERE teamName="开拓者";
UPDATE team SET ballHall="AT&T中心" ,teamAge=2018-1976,toalMatch=82,victoryNumber=47,championNumber=5  WHERE teamName="马刺";

#先补充数据(教练信息)
ALTER TABLE coach DROP toalMatch, DROP victoryNumber
DELETE FROM coach
INSERT INTO coach VALUES(NULL,"科尔",2,(SELECT teamId FROM team WHERE team.`teamName`='勇士'));
INSERT INTO coach VALUES(NULL,"史蒂文斯",0,(SELECT teamId FROM team WHERE team.`teamName`='凯尔特人'));
INSERT INTO coach VALUES(NULL,"德安东尼",0,(SELECT teamId FROM team WHERE team.`teamName`='火箭'));
INSERT INTO coach VALUES(NULL,"布登霍尔泽",0,(SELECT teamId FROM team WHERE team.`teamName`='老鹰'));
INSERT INTO coach VALUES(NULL,"克利福德",0,(SELECT teamId FROM team WHERE team.`teamName`='黄蜂'));
INSERT INTO coach VALUES(NULL,"金特里",1,(SELECT teamId FROM team WHERE team.`teamName`='鹈鹕'));
INSERT INTO coach VALUES(NULL,"霍伊博格",0,(SELECT teamId FROM team WHERE team.`teamName`='公牛'));
INSERT INTO coach VALUES(NULL,"泰伦-卢",1,(SELECT teamId FROM team WHERE team.`teamName`='骑士'));
INSERT INTO coach VALUES(NULL,"比克斯塔夫",0,(SELECT teamId FROM team WHERE team.`teamName`='灰熊'));
INSERT INTO coach VALUES(NULL,"斯托茨",0,(SELECT teamId FROM team WHERE team.`teamName`='开拓者'));
INSERT INTO coach VALUES(NULL,"波波维奇",5,(SELECT teamId FROM team WHERE team.`teamName`='马刺'));

#创建球员表
CREATE TABLE player(
#球员ID  整型  无符号  自增  主键
playerId INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
#球员名称   字符串  不能为空  唯一
playerName VARCHAR(20) NOT NULL ,
#位置
playerPosition VARCHAR(20) NOT NULL ,
#号码
playerNumber INT UNSIGNED NOT NULL ,
#球队ID
teamId INT UNSIGNED  NOT NULL,

FOREIGN KEY(teamId) REFERENCES team (teamId)  ON DELETE CASCADE
);

#插入球员数据
INSERT INTO player VALUES(NULL,"斯蒂芬-库里","后卫",30,(SELECT teamId FROM team WHERE team.`teamName`='勇士'));
INSERT INTO player VALUES(NULL,"凯文-杜兰特","前锋",35,(SELECT teamId FROM team WHERE team.`teamName`='勇士'));
INSERT INTO player VALUES(NULL,"德雷蒙德-格林","前锋",23,(SELECT teamId FROM team WHERE team.`teamName`='勇士'));
INSERT INTO player VALUES(NULL,"克雷-汤普森","后卫",11,(SELECT teamId FROM team WHERE team.`teamName`='勇士'));
INSERT INTO player VALUES(NULL,"伊格达拉","后卫",9,(SELECT teamId FROM team WHERE team.`teamName`='勇士'));

INSERT INTO player VALUES(NULL,"凯里-欧文","后卫",11,(SELECT teamId FROM team WHERE team.`teamName`='凯尔特人'));
INSERT INTO player VALUES(NULL,"格雷格-门罗","前锋",55,(SELECT teamId FROM team WHERE team.`teamName`='凯尔特人'));
INSERT INTO player VALUES(NULL,"戈登-海沃德","前锋",20,(SELECT teamId FROM team WHERE team.`teamName`='凯尔特人'));
INSERT INTO player VALUES(NULL,"艾尔-霍福德","前锋",42,(SELECT teamId FROM team WHERE team.`teamName`='凯尔特人'));
INSERT INTO player VALUES(NULL,"贝恩斯","中锋",46,(SELECT teamId FROM team WHERE team.`teamName`='凯尔特人'));

INSERT INTO player VALUES(NULL,"詹姆斯-哈登","后卫",13,(SELECT teamId FROM team WHERE team.`teamName`='火箭'));
INSERT INTO player VALUES(NULL,"乔-约翰逊","前锋",7,(SELECT teamId FROM team WHERE team.`teamName`='火箭'));
INSERT INTO player VALUES(NULL,"克里斯-保罗","后卫",3,(SELECT teamId FROM team WHERE team.`teamName`='火箭'));
INSERT INTO player VALUES(NULL,"莱恩-安德森","前锋",33,(SELECT teamId FROM team WHERE team.`teamName`='火箭'));
INSERT INTO player VALUES(NULL,"戈登","后卫",10,(SELECT teamId FROM team WHERE team.`teamName`='火箭'));

INSERT INTO player VALUES(NULL,"普拉姆利","中锋",18,(SELECT teamId FROM team WHERE team.`teamName`='老鹰'));
INSERT INTO player VALUES(NULL,"贝兹莫尔","后卫",24,(SELECT teamId FROM team WHERE team.`teamName`='老鹰'));
INSERT INTO player VALUES(NULL,"施罗德","后卫",17,(SELECT teamId FROM team WHERE team.`teamName`='老鹰'));
INSERT INTO player VALUES(NULL,"穆斯卡拉","前锋",31,(SELECT teamId FROM team WHERE team.`teamName`='老鹰'));
INSERT INTO player VALUES(NULL,"戴德蒙","中锋",14,(SELECT teamId FROM team WHERE team.`teamName`='老鹰'));
 
INSERT INTO player VALUES(NULL,"霍华德","中锋",12,(SELECT teamId FROM team WHERE team.`teamName`='黄蜂'));
INSERT INTO player VALUES(NULL,"巴图姆","后卫",5,(SELECT teamId FROM team WHERE team.`teamName`='黄蜂'));
INSERT INTO player VALUES(NULL,"肯巴-沃克","后卫",15,(SELECT teamId FROM team WHERE team.`teamName`='黄蜂'));
INSERT INTO player VALUES(NULL,"威廉姆斯","前锋",2,(SELECT teamId FROM team WHERE team.`teamName`='黄蜂'));
INSERT INTO player VALUES(NULL,"吉尔克里斯特","前锋",14,(SELECT teamId FROM team WHERE team.`teamName`='黄蜂'));

INSERT INTO player VALUES(NULL,"考辛斯","中锋",0,(SELECT teamId FROM team WHERE team.`teamName`='鹈鹕'));
INSERT INTO player VALUES(NULL,"奥卡福","中锋",50,(SELECT teamId FROM team WHERE team.`teamName`='鹈鹕'));
INSERT INTO player VALUES(NULL,"霍勒迪","后卫",11,(SELECT teamId FROM team WHERE team.`teamName`='鹈鹕'));
INSERT INTO player VALUES(NULL,"朗多","后卫",9,(SELECT teamId FROM team WHERE team.`teamName`='鹈鹕'));
INSERT INTO player VALUES(NULL,"戴维斯","前锋",23,(SELECT teamId FROM team WHERE team.`teamName`='鹈鹕'));
 
INSERT INTO player VALUES(NULL,"洛佩兹","中锋",42,(SELECT teamId FROM team WHERE team.`teamName`='公牛'));
INSERT INTO player VALUES(NULL,"阿西克","中锋",3,(SELECT teamId FROM team WHERE team.`teamName`='公牛'));
INSERT INTO player VALUES(NULL,"冯莱","前锋",30,(SELECT teamId FROM team WHERE team.`teamName`='公牛'));
INSERT INTO player VALUES(NULL,"拉文","后卫",8,(SELECT teamId FROM team WHERE team.`teamName`='公牛'));
INSERT INTO player VALUES(NULL,"佩恩","后卫",22,(SELECT teamId FROM team WHERE team.`teamName`='公牛'));
 
INSERT INTO player VALUES(NULL,"詹姆斯","后卫",23,(SELECT teamId FROM team WHERE team.`teamName`='骑士'));
INSERT INTO player VALUES(NULL,"乐福","前锋",0,(SELECT teamId FROM team WHERE team.`teamName`='骑士'));
INSERT INTO player VALUES(NULL,"格林","前锋",32,(SELECT teamId FROM team WHERE team.`teamName`='骑士'));
INSERT INTO player VALUES(NULL,"希尔","后卫",3,(SELECT teamId FROM team WHERE team.`teamName`='骑士'));
INSERT INTO player VALUES(NULL,"卡尔德隆","后卫",81,(SELECT teamId FROM team WHERE team.`teamName`='骑士'));
 
INSERT INTO player VALUES(NULL,"加索尔","中锋",33,(SELECT teamId FROM team WHERE team.`teamName`='灰熊'));
INSERT INTO player VALUES(NULL,"帕森斯","前锋",25,(SELECT teamId FROM team WHERE team.`teamName`='灰熊'));
INSERT INTO player VALUES(NULL,"埃文斯","后卫",12,(SELECT teamId FROM team WHERE team.`teamName`='灰熊'));
INSERT INTO player VALUES(NULL,"康利","后卫",11,(SELECT teamId FROM team WHERE team.`teamName`='灰熊'));
INSERT INTO player VALUES(NULL,"查尔莫斯","后卫",6,(SELECT teamId FROM team WHERE team.`teamName`='灰熊'));
 
INSERT INTO player VALUES(NULL,"阿米努","前锋",8,(SELECT teamId FROM team WHERE team.`teamName`='开拓者')); 
INSERT INTO player VALUES(NULL,"戴维斯","中锋",17,(SELECT teamId FROM team WHERE team.`teamName`='开拓者')); 
INSERT INTO player VALUES(NULL,"特纳","后卫",1,(SELECT teamId FROM team WHERE team.`teamName`='开拓者')); 
INSERT INTO player VALUES(NULL,"利拉德","后卫",0,(SELECT teamId FROM team WHERE team.`teamName`='开拓者')); 
INSERT INTO player VALUES(NULL,"迈尔斯-莱昂纳德","中锋",11,(SELECT teamId FROM team WHERE team.`teamName`='开拓者')); 
 
INSERT INTO player VALUES(NULL,"阿尔德里奇","前锋",12,(SELECT teamId FROM team WHERE team.`teamName`='马刺')); 
INSERT INTO player VALUES(NULL,"莱昂纳德","前锋",2,(SELECT teamId FROM team WHERE team.`teamName`='马刺')); 
INSERT INTO player VALUES(NULL,"吉诺比利","后卫",20,(SELECT teamId FROM team WHERE team.`teamName`='马刺')); 
INSERT INTO player VALUES(NULL,"托尼-帕克","后卫",9,(SELECT teamId FROM team WHERE team.`teamName`='马刺')); 
INSERT INTO player VALUES(NULL,"鲁迪-盖伊","前锋",22,(SELECT teamId FROM team WHERE team.`teamName`='马刺')); 
 

#子查询   子查询指的是嵌套在查询内部，并且始终出现在小括号里边
#子查询   子查询可以包含多个关键字或条件  DISTINCT\group by \order by\函数等等
#子查询   子查询的外层查询可以是select \ insert\update \set\do
#子查询   子查询可以返回标量、一行、一列或者子查询

#比较运算符引发的子查询 =、>、<、>=、<=、!= 
#查询平均值
SELECT AVG(team.`championNumber`) FROM team;
#查询平均值保留两位小数
SELECT ROUND(AVG(team.`championNumber`),2 )FROM team;
#查询总冠军数量在平均值以上的
SELECT * FROM team WHERE team.`championNumber`>(SELECT ROUND(AVG(team.`championNumber`),2 )FROM team);
#使用 any\some、all关键字来修饰运算符
#查询凯尔特人队队员的号码
SELECT player.`playerNumber` FROM player WHERE player.`teamId` = (SELECT team.`teamId` FROM team WHERE team.`teamName`="凯尔特人");
#查询所有球员中，背号>凯尔特人球员的背号的球员
#使用any 和some 的意思是一样的  只要满足返回集合中的任意一个就算满足条件
#在查询凯尔特人队队员的号码  返回的集合是 11，55，20，42，46  也就是说，使用any和some 只要背号>11就满足条件
SELECT *FROM player WHERE player.`playerNumber`> ANY
(SELECT player.`playerNumber` FROM player WHERE player.`teamId` = 
	(SELECT team.`teamId` FROM team WHERE team.`teamName`="凯尔特人")
);

SELECT *FROM player WHERE player.`playerNumber`> SOME
(SELECT player.`playerNumber` FROM player WHERE player.`teamId` = 
	(SELECT team.`teamId` FROM team WHERE team.`teamName`="凯尔特人")
);

#但是使用all关键字修饰的时候，就是要满足所有的值，才算符合条件  就是必须背号>55才满足
SELECT *FROM player WHERE player.`playerNumber`> ALL
(SELECT player.`playerNumber` FROM player WHERE player.`teamId` = 
	(SELECT team.`teamId` FROM team WHERE team.`teamName`="凯尔特人")
);

SELECT *FROM player WHERE player.`playerNumber`>55

#由[NOT]IN/EXISTS引发的子查询
#EXISTS很少用，这里不说了
#=ANY和IN等效
#！=ALL和NOT IN等效
#查询背号和凯尔特人队的都不一样的
SELECT *FROM player WHERE player.`playerNumber` !=ALL
(SELECT player.`playerNumber` FROM player WHERE player.`teamId` = 
	(SELECT team.`teamId` FROM team WHERE team.`teamName`="凯尔特人")
);
#用这个来验证
SELECT *FROM player WHERE player.`playerNumber` !=11 AND player.`playerNumber` !=55 
AND player.`playerNumber` !=20 AND player.`playerNumber` !=42  AND player.`playerNumber` !=46



#多表更新
#把球队的总冠军数量赋值给队里的球员
#首先给球员添加总冠军数量的字段
ALTER TABLE player ADD championNumber INT NOT NULL DEFAULT 0;
#多表更新   
#UPDATE 要更新的表名称  连接方式    要连接的表  ON  连接条件                     SET 要修改的值            =   改成哪个数
UPDATE     player       INNER JOIN    team      ON player.`teamId`=team.`teamId` SET player.`championNumber`=team.`championNumber`

#把冠军球队放到一个新的表里边
CREATE TABLE championTeam(
	teamId INT  UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
	teamName VARCHAR(20) NOT NULL
)SELECT team.`teamName` FROM team WHERE team.`championNumber`>0;







#表的连接
# A表  连接类型  B表  ON 连接条件
#INNER JOIN 内连接  在MySQL中，JOIN,CROSS JOIN 和 INNER JOIN是等价的
#LEFT[OUTER] JOIN 左外连接
#RIGHT [OUTER] JOIN 右外连接

#先删除player表和team表的主外键关系
SHOW CREATE TABLE player
#查询出来的结果是  test_ibfk_1
CREATE TABLE `player` (
  `playerId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `playerName` VARCHAR(20) NOT NULL,
  `playerPosition` VARCHAR(20) NOT NULL,
  `playerNumber` INT(10) UNSIGNED NOT NULL,
  `teamId` INT(10) UNSIGNED NOT NULL,
  `championNumber` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`playerId`),
  KEY `teamId` (`teamId`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`teamId`) REFERENCES `team` (`teamId`) ON DELETE CASCADE
) ENGINE=INNODB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8

#然后用 player_ibfk_1去删除外键
ALTER TABLE player DROP FOREIGN KEY  player_ibfk_1
#然后插入一个球员，该球队的id不在team表中
INSERT INTO player VALUES(NULL,"李小米","后卫",6,999,5); 
#然后插入两个球队，该球队下没有球员
INSERT INTO team VALUES(NULL,"76人",2018-1976,3,"富国银行中心",82,52);
INSERT INTO team VALUES(NULL,"森林狼",2018-1989,0,"标靶中心",82,47);

#用一下内连接  内连接只能查询两个表的交集，都有的部分数据，刚才插入进去的李小米就没有
SELECT team.`teamName`,player.`playerName`,player.`playerPosition`,player.`playerNumber` 
FROM team INNER JOIN player ON team.`teamId`=player.`teamId`

#外连接 左外连接  结果集中包括左边中的全部内容和右表中符合条件的数据
SELECT team.`teamName`,player.`playerName`,player.`playerPosition`,player.`playerNumber` 
FROM team LEFT JOIN player ON team.`teamId`=player.`teamId`

#外连接 右外连接  结果集中包括右边中的全部内容和左表中符合条件的数据
SELECT team.`teamName`,player.`playerName`,player.`playerPosition`,player.`playerNumber` 
FROM team RIGHT JOIN player ON team.`teamId`=player.`teamId`
#多张数据表的连接
SELECT team.`teamName` ,coach.`coachName`,player.`playerName`,player.`playerPosition`,player.`playerNumber`
FROM team INNER JOIN player ON team.`teamId`=player.`teamId` INNER JOIN coach ON team.`teamId`=coach.`teamId`

A LEFT JOIN B join_condition
1、B表的结果集依赖A表
2、A表的结果集根据做链接条件依赖所有数据表(B表除外)
3、左外连接条件决定如何让检索B表(在没有指定where条件的情况下)
4、如果A表的某条记录符合where条件，到那时B表中没有符合条件的记录，将生成一个所有列位空的额外的B行 


#自连接
#这里咱们假设教练员是有分类的，比如有3层分类，一般情况下会去设计三个表。但是如果有N层分类呢？怎么设计
#这里咱们给教练表增加一个字段  一个上一层的分类id,这样就相当于有了一个N层分类的表了
#先改造一下数据表和数据
ALTER TABLE coach ADD parentId INT UNSIGNED  DEFAULT 0;
 
UPDATE coach SET coach.`parentId`=0 WHERE coach.`coachName`='波波维奇';

UPDATE coach SET coach.`parentId`=(SELECT coachId FROM coach WHERE coachName='波波维奇') 
WHERE coach.`coachName`='科尔';

UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='波波维奇') 
WHERE coach.`coachName`='科尔';

UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='波波维奇') 
WHERE coach.`coachName`='史蒂文斯';

UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='科尔') 
WHERE coach.`coachName`='德安东尼';
UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='科尔') 
WHERE coach.`coachName`='布登霍尔泽';

UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='史蒂文斯') 
WHERE coach.`coachName`='克利福德';
UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='史蒂文斯') 
WHERE coach.`coachName`='金特里';

 
UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='德安东尼') 
WHERE coach.`coachName`='霍伊博格';
UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='德安东尼') 
WHERE coach.`coachName`='泰伦-卢';
UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='霍伊博格') 
WHERE coach.`coachName`='比克斯塔夫';
UPDATE coach SET coach.`parentId`=(SELECT c.coachId FROM (SELECT coach.* FROM coach) AS c  WHERE c.coachName='泰伦-卢') 
WHERE coach.`coachName`='斯托茨';

  
#然后查询出来自己的id和名称  以及上一层的名称
SELECT s.coachId,s.coachName,p.coachName FROM coach AS s LEFT JOIN coach AS p ON s.`parentId`=p.`coachId`
#然后查询出来自己的id和名称  以及下一层的名称
SELECT p.coachId,p.coachName,s.coachName FROM coach AS p RIGHT JOIN coach AS s ON s.`parentId`=p.`coachId`

#多表删除
DELETE FROM championTeam
INSERT INTO championTeam(championTeam.`teamName`) SELECT team.`teamName`  FROM team ;
#删除总冠军数量为0的球队
DELETE c FROM championTeam AS c LEFT JOIN team AS t ON c.`teamName`=t.`teamName` WHERE t.championNumber =0;



#查询全部
SELECT * FROM team;
SELECT * FROM coach;
SELECT * FROM test;
SELECT * FROM player;
SELECT * FROM championTeam;