#!/usr/bin/python3

#【描述】   gitcode.net api使用例子
#【依赖】   
#【术语】  #E_==Entity_==实体  
#【备注】   


import typing

# 新建token,勾选 api、read_user、read_api、read_repository, 不勾选 write_repository
#     https://gitcode.net/-/profile/personal_access_tokens
gitcode_token="szgTdCTbpJ_ikGzZV5AR"


#gitcode.net api 文档:  
#  https://docs.gitlab.cn/jh/api/groups.html
#  https://gitcode.net/gitcode/help-docs/-/wikis/docs/api   内容贫瘠

# gitcode.net api 分页参数
#   页码 page 默认是1,  页大小 per_page 默认20 最大100
#  https://gitcode.net/gitcode/help-docs/-/wikis/docs/api#%E5%81%8F%E7%A7%BB%E5%88%86%E9%A1%B5

#获取公开的project列表? 这不是我期望的
# https://gitcode.net/api/v4/projects?private_token=$gitcode_token

#获取 我的 组列表
#接口 https://gitcode.net/api/v4/groups?private_token=szgTdCTbpJ_ikGzZV5AR
#页面 https://gitcode.net/users/hfcaoguilin/groups


#python-字典转为类对象  https://www.cnblogs.com/yaoqingzhuan/p/17552733.html
class Dict2Obj:
    def __init__(self, dct):
        for key, value in dct.items():
            if isinstance(value, dict):
                setattr(self, key, Dict2Obj(value))
            else:
                setattr(self, key, value)
                

""" 接口 api/v4/groups 响应举例
[
{'id': 2676829, 'web_url': 'https://gitcode.net/groups/pubx/51', 'name': '51', 'path': '51', 'description': '', 'visibility': 'public', 'share_with_group_lock': False, 'require_two_factor_authentication': False, 'two_factor_grace_period': 48, 'project_creation_level': 'developer', 'auto_devops_enabled': None, 'subgroup_creation_level': 'maintainer', 'emails_disabled': None, 'mentions_disabled': None, 'lfs_enabled': True, 'default_branch_protection': 2, 'avatar_url': None, 'request_access_enabled': True, 'full_name': 'pubx / 51', 'full_path': 'pubx/51', 'created_at': '2023-09-22T00:28:09.966+08:00', 'parent_id': 1486786}
, ...]
"""
class E_Group:
    id:int
    parent_id:int
    visibility:str
    lfs_enabled:bool
    web_url:str
    name:str
    path:str
    description:str
    full_name:str
    full_path:str
    created_at:str

#组织树中的一个节点
class E_Namespace:
    id:int
    name:str
    path:str
    full_path:str
    kind:str #比如"group"
    parent_id:int
    web_url:str
    
""" 接口  api/v4/projects 响应举例
[
{"id": 563839, "description": "java函数钩子（字节码层）（放弃原因？）", "name": "instrmj", "name_with_namespace": "myz / fnHok / instrmj", "path": "instrmj", "path_with_namespace": "myz/fnHok/instrmj", "created_at": "2024-04-02T13:34:13.834+08:00", "default_branch": "master", "tag_list": [], "ssh_url_to_repo": "git@gitcode.net:myz/fnHok/instrmj.git", "http_url_to_repo": "https://gitcode.net/myz/fnHok/instrmj.git", "web_url": "https://gitcode.net/myz/fnHok/instrmj", "readme_url": "https://gitcode.net/myz/fnHok/instrmj/-/blob/master/README.md", "avatar_url": null, "forks_count": 0, "star_count": 0, "github_star_count": 0, "github_fork_count": 0, "import_url": "https://gitcode.com/pubz/instrmj.git", "last_activity_at": "2024-04-02T13:34:13.834+08:00", "namespace": {"id": 2922526, "name": "fnHok", "path": "fnHok", "kind": "group", "full_path": "myz/fnHok", "parent_id": 2748771, "avatar_url": null, "web_url": "https://gitcode.net/groups/myz/fnHok"}, "_links": {"self": "https://gitcode.net/api/v4/projects/563839", "issues": "https://gitcode.net/api/v4/projects/563839/issues", "merge_requests": "https://gitcode.net/api/v4/projects/563839/merge_requests", "repo_branches": "https://gitcode.net/api/v4/projects/563839/repository/branches", "labels": "https://gitcode.net/api/v4/projects/563839/labels", "events": "https://gitcode.net/api/v4/projects/563839/events", "members": "https://gitcode.net/api/v4/projects/563839/members"}, "packages_enabled": true, "empty_repo": false, "archived": false, "visibility": "private", "resolve_outdated_diff_discussions": false, "container_registry_enabled": false, "container_expiration_policy": {"cadence": "1d", "enabled": false, "keep_n": 10, "older_than": "90d", "name_regex": ".*", "name_regex_keep": null, "next_run_at": "2024-04-03T13:34:13.881+08:00"}, "issues_enabled": true, "merge_requests_enabled": true, "wiki_enabled": true, "jobs_enabled": true, "snippets_enabled": false, "service_desk_enabled": false, "service_desk_address": null, "can_create_merge_request_in": true, "issues_access_level": "enabled", "repository_access_level": "enabled", "merge_requests_access_level": "enabled", "forking_access_level": "enabled", "wiki_access_level": "enabled", "builds_access_level": "enabled", "snippets_access_level": "disabled", "pages_access_level": "private", "operations_access_level": "enabled", "analytics_access_level": "enabled", "emails_disabled": null, "shared_runners_enabled": true, "lfs_enabled": true, "creator_id": 186454, "import_status": "finished", "open_issues_count": 0, "ci_default_git_depth": 50, "ci_forward_deployment_enabled": true, "public_jobs": true, "build_timeout": 3600, "auto_cancel_pending_pipelines": "enabled", "build_coverage_regex": null, "ci_config_path": ".codechina-ci.yml", "shared_with_groups": [], "only_allow_merge_if_pipeline_succeeds": false, "allow_merge_on_skipped_pipeline": null, "request_access_enabled": true, "only_allow_merge_if_all_discussions_are_resolved": false, "remove_source_branch_after_merge": true, "printing_merge_request_link_enabled": true, "merge_method": "merge", "suggestion_commit_message": null, "auto_devops_enabled": false, "auto_devops_deploy_strategy": "continuous", "autoclose_referenced_issues": true, "permissions": {"project_access": null, "group_access": {"access_level": 50, "notification_level": 3}}}
,...]
"""
class E_Prj:
    id:int
    name:str
    path:str
    description:str
    name_with_namespace:str
    path_with_namespace:str
    ssh_url_to_repo:str #仓库地址 ssh形式 git@gitcode.net:x/y/prj.git
    http_url_to_repo:str #仓库地址 http形式 https://gitcode.net/x/y/prj.git
    web_url:str #仓库主页url
    default_branch:str
    tag_list:typing.List[str]
    empty_repo:bool #是否空仓库
    archived:bool #是否已archive
    visibility:str #仓库可见性 比如 "private"
    lfs_enabled:bool #是否启动lfs
    creator_id:int #仓库创建者（仓库创建用户id?）
    import_status:str #导入状态 比如 "finished"
    namespace: E_Namespace #组织树中的一个节点
    created_at:str
    
    

PageSize:int=100

import requests
import json,typing
from types import SimpleNamespace

#正常打印所有组织 
#   不到100个组织，因此一页足够了
Url_groups=f"https://gitcode.net/api/v4/groups?private_token={gitcode_token}&per_page={PageSize}&page=1"
resp:requests.Response=requests.get(url=Url_groups)
group_dct_ls:typing.List[typing.Dict]=resp.json()
# grp0:E_Group= Dict2Obj(group_dct_ls[0])
groups:typing.List[E_Group]=[Dict2Obj(dctK) for dctK in group_dct_ls]
# [print(f"group_id={grpK.id},full_path={grpK.full_path},parent_id:{grpK.parent_id}") for grpK in groups]



# 仓库接口 文档
#   https://docs.gitlab.cn/jh/api/projects.html#%E5%88%97%E5%87%BA%E6%89%80%E6%9C%89%E9%A1%B9%E7%9B%AE
#   owned=true 只列出 我的项目 (不列出别人的项目)
#正常打印所有仓库
def get_prjs(url_param_txt:str, pageK:int):
    Url_projects=f"https://gitcode.net/api/v4/projects?private_token={gitcode_token}&owned=true&per_page={PageSize}&page={pageK}&{url_param_txt}"
    resp:requests.Response=requests.get(url=Url_projects)
    prj_dct_ls:typing.List[typing.Dict]=resp.json()
    # prj0:E_Group= Dict2Obj(prj_dct_ls[0])
    # print( json.dumps(prj_dct_ls[0]) )
    prjs:typing.List[E_Prj]=[Dict2Obj(prjK) for prjK in prj_dct_ls]
    
    msg=f"追加url参数 {url_param_txt},第{pageK}页,响应如下"
    print(msg)
    if prjs is None or len(prjs)==0:
        print("返回为空")
    else :
        [print(f"prj_id={pK.id},path={pK.path},http_url_to_repo={pK.http_url_to_repo},group__full_path:{pK.namespace.full_path}") for pK in prjs]
    print("")


ArchivedFalse:str="archived=false&"
ArchivedTrue:str="archived=true&"
get_prjs(ArchivedFalse, 1) #未归档仓库 第1页
get_prjs(ArchivedFalse, 2) #未归档仓库 第2页
get_prjs(ArchivedTrue, 1)  #已归档仓库 第1页
get_prjs(ArchivedTrue, 2)  #已归档仓库 第2页
end=True