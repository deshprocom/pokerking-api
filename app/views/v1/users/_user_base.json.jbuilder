json.user_id            user.user_uuid
json.account            user.account_id
json.nickname           user.nickname
json.gender             user.gender.to_s
json.avatar             user.avatar_url.to_s
json.mobile             user.mobile.to_s
json.country_code       user.country_code.to_s
json.email              user.email.to_s
json.reg_date           user.reg_date.to_i
json.last_visit         user.last_visit.to_i
json.created_at         user.created_at.to_i
