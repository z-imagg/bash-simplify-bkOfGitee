#!/usr/bin/python3

#【描述】   gitcode.net api使用例子
#【依赖】   
#【术语】  #E_==Entity_==实体  
#【备注】   

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

PageSize:int=100

import requests
import json,typing
from types import SimpleNamespace


Url_groups=f"https://gitcode.net/api/v4/groups?private_token={gitcode_token}&per_page={PageSize}"
resp:requests.Response=requests.get(url=Url_groups)
group_dct_ls:typing.List[typing.Dict]=resp.json()
# grp0:E_Group= Dict2Obj(group_dct_ls[0])
groups:typing.List[E_Group]=[Dict2Obj(dctK) for dctK in group_dct_ls]
[print(f"group_id={grpK.id},full_path={grpK.full_path},parent_id:{grpK.parent_id}") for grpK in groups]
end=True