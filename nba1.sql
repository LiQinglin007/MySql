#创建球队表
CREATE TABLE team(
#球队编号 整型 无符号 自增  主键
teamId INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
#球队名称  字符串  不能为空  唯一
teamName VARCHAR(20) NOT NULL UNIQUE,
#球队年龄  整型 无符号   可以为空
teamAge TINYINT  UNSIGNED NULL ,
#总场次
toalMatch INT NOT NULL,
#胜场 整型  不能为空
victoryNumber INT NOT NULL ,
#冠军数量
championNumber INT NOT NULL,
#球馆名称
ballHall VARCHAR(40) 
);

#创建教练表
CREATE TABLE coach(
#教练ID  整型  无符号  自增  主键
coachId INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
#教练名称   字符串  不能为空  唯一
coachName VARCHAR(20) NOT NULL UNIQUE,
#总场次
toalMatch INT NOT NULL DEFAULT 0,
#胜场 整型  不能为空
victoryNumber INT NOT NULL DEFAULT 0,
#冠军数量
championNumber INT NOT NULL DEFAULT 0,
#球队ID
teamId INT UNSIGNED  NOT NULL,

FOREIGN KEY(teamId) REFERENCES team (teamId)  ON DELETE CASCADE
);

#修改表名
ALTER TABLE team RENAME TO teamUpdate;
ALTER TABLE teamUpdate RENAME AS team;
RENAME TABLE team TO teamUpdate,coach TO coachUpdate;
RENAME TABLE teamUpdate TO team,coachUpdate TO coach;


#查看表结构
SHOW COLUMNS FROM team;
#添加列在最开始
ALTER TABLE team ADD testAdd VARCHAR(20) FIRST
#添加列在最后边
ALTER TABLE team ADD testAddLast VARCHAR(20) 
#添加列在某一列后边
ALTER TABLE team ADD testAddCenter VARCHAR(20)  AFTER teamName
#添加多列(这个不能设置插入的位置，只能插入到最后边)
ALTER TABLE team ADD testAddList1 VARCHAR(20),ADD testAddList2 VARCHAR(20),ADD testAddList3 VARCHAR(20) 

#查看表结构
SHOW COLUMNS FROM team;
#删除列
ALTER TABLE team DROP testAdd 
#批量删除列
ALTER TABLE team DROP testAddList1, DROP testAddList2, DROP testAddList3

#结合使用
ALTER TABLE team DROP testAddLast, ADD testAddNewLast VARCHAR(20) 

#修改数据表
#把某个字段移动到最开始
ALTER TABLE team MODIFY testAddNewLast VARCHAR(20) FIRST
#查看表结构
SHOW COLUMNS FROM team;

#修改字段属性和位置(这里注意，由大类型修改成小类型的时候，可能会造成是数据的丢失)
ALTER TABLE team MODIFY testAddNewLast VARCHAR(10) DEFAULT "小米" FIRST
#查看表结构
SHOW COLUMNS FROM team;
#修改字段属性和位置  移动到哪个字段后边
ALTER TABLE team MODIFY testAddNewLast VARCHAR(20) DEFAULT "小米修改属性" AFTER teamName
#修改列名称
ALTER TABLE team CHANGE testAddNewLast testUpdateLast VARCHAR(20) DEFAULT "小米修改属性和字段名称" AFTER teamAge
#把team表恢复原状 
ALTER TABLE team DROP testAddCenter, DROP testUpdateLast
 
 

#创建测试表
CREATE TABLE test(
#ID  整型 
testId INT ,
#名称   字符串  
testName VARCHAR(20) ,
);

#添加约束

#添加主键  CONSTRAINT关键字是给后边的属性添加名字的   可以省略该关键字 写成
#ALTER TABLE test ADD PRIMARY KEY(testId)
ALTER TABLE test ADD CONSTRAINT PK_test_id PRIMARY KEY(testId)
#删除主键约束
ALTER TABLE test DROP  PRIMARY KEY


#添加唯一约束
ALTER TABLE test ADD  UNIQUE(testName)
#删除唯一约束
#先查询出来 testName字段的唯一约束的名字   查询出来，可以看到key_name是testName
SHOW INDEXES FROM test
#然后用testName 去删除这个唯一约束
ALTER TABLE test DROP  KEY testName
#然后用testName 去删除这个唯一约束
ALTER TABLE test DROP  INDEX testName 

#添加球队ID
ALTER TABLE test ADD teamId INT UNSIGNED  NOT NULL
#添加外键约束
ALTER TABLE test ADD  FOREIGN KEY(teamId) REFERENCES team (teamId)  ON DELETE CASCADE
SHOW COLUMNS FROM test 
#删除外键约束要加上外键约束的名称
#先查询出来外键约束的名称
SHOW CREATE TABLE test
#查询出来的结果是  test_ibfk_1
CREATE TABLE `test` (
  `testId` INT(11) NOT NULL DEFAULT '0',
  `testName` VARCHAR(20),
  `teamId` INT(10) UNSIGNED NOT NULL,
  KEY `teamId` (`teamId`),
  CONSTRAINT `test_ibfk_1` FOREIGN KEY (`teamId`) REFERENCES `team` (`teamId`) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8

#然后用 test_ibfk_1去删除外键
ALTER TABLE test DROP FOREIGN KEY  test_ibfk_1


#添加默认约束
ALTER TABLE test ALTER testName SET DEFAULT "小米"
#删除默认约束
ALTER TABLE test ALTER testName DROP DEFAULT  

SHOW COLUMNS FROM test; 
 
