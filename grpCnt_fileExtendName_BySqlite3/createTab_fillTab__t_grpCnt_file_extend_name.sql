


-- 【描述】  创建、填充 分组统计表  文件扩展名 file_extend_name
-- 【依赖】   
-- 【术语】 
-- 【备注】  
-- 【例子用法】  
--    source /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/__save_filePathOfDir_to_sqlite3Db.sh ; __save_filePathOfDir_to_sqlite3Db /d2/Open-Cascade-SAS/OCCT-7_8_1 /tmp/sqlite3_db_filePath_OCCT-master.db
--  cat  /app/bash-simplify/grpCnt_fileExtendName_BySqlite3/createTab_fillTab__t_grpCnt_file_extend_name.sql | sqlite3 /tmp/sqlite3_db_filePath_OCCT-master.db 

-- 删除为了凑齐insert语法的行
delete from 't_fpath_OCCT-master' where fpath='END_ROW';

drop  TABLE if exists t_grpCnt_file_extend_name ;

-- 创建 分组统计表  文件扩展名 file_extend_name
create TABLE t_grpCnt_file_extend_name (file_extend_name text, cnt int);

-- 填充 分组统计表  文件扩展名 file_extend_name
insert into t_grpCnt_file_extend_name
select file_extend_name, count(*) as cnt from 't_fpath_OCCT-master' group by file_extend_name  order by cnt desc
;