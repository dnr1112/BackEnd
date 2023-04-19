select
	ut.user_id,
    ut.email,
    ut.password,
    ut.name,
    ut.provider,
    
    at.authority_id,
    at.user_id,
    at.role_id,
    
    rt.role_id,
    rt.role_name
from
	user_tb ut
    left outer join authority_tb at on(at.user_id = ut.user_id)
    left outer join role_tb rt on (rt.role_id = at.role_id)
where
	ut.email = ""