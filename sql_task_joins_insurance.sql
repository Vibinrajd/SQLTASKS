
-- 1.Based on Policy Holder Country  find the number of Policies ?

select 
pa.country,
count(distinct po.PolicyID)
from insurance.policy po
join insurance.party pa
on po.PolicyHolderID = pa.PartyID 
group by 1
limit 5;

-- 2.Which country policy holder has created more number of claims?

select 
pt.country,
count(distinct cl.IncidentID) as claim_count
from insurance.claims cl
join insurance.policy po
on cl.PolicyID = po.PolicyID
join insurance.party pt
on po.PolicyHolderID = pt.PartyID
group by 1
order by 2 desc
limit 5;

-- 3.Find the premium each policy.

select
po.PolicyID,
sum(pr.writtenPremium)
from insurance.policy po
join insurance.premium pr
on po.PolicyID = pr.PolicyID
group by 1
limit 5;

-- 4.find the policy where claim amount(LossIncured) paid is greater then the premium.

with premium as (
select
po.PolicyID,
sum(pr.writtenPremium) premium
from insurance.policy po
join insurance.premium pr
on po.PolicyID = pr.PolicyID
group by 1),
loss as (
select 
po.PolicyID,
sum(cl.LossIncured) loss
from insurance.claims cl
join insurance.policy po
on po.PolicyID = cl.PolicyID
group by 1)
select
l.PolicyID 
from loss l
join premium p
on l.PolicyID = p.PolicyID 
where p.premium < l.loss;

-- 5.Find the policy where claim created date (col:lossDate) before the policy effective date
	-- (col:PolicyStartDarte) and print policy number and holder name.

select
po.PolicyID,
pa.name
from insurance.policy po
join insurance.claims cl
on po.PolicyID = cl.PolicyID
join insurance.party pa
on po.PolicyHolderID = pa.PartyID
where po.PolicyStartDarte < cl.lossDate
limit 5;
