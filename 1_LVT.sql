---Checking the data given ,sign_up_data,user_after_completion and reward
SELECT * FROM Greedy_game.dbo.['Q2_users signup$']
SELECT * FROM Greedy_game.dbo.['Q2_User offer completion data$']
SELECT * FROM Greedy_game.dbo.['Q2_rewards details$']


-----after checking the data writing query to calculate the LTV of customer 
SELECT 
	r.[user_id],
	r.app_id,
	d.user_id AS offer_completed_user_id,
	---converting the payout value amount into rupees
	ISNULL(SUM(ro.total_payout_in_paise) / 100.0, 0) AS total_payout,
	
	---counting the offers completd by the customer
	COUNT(DISTINCT d.reward_id) AS total_offers_completed,

	---counting the total rewards earned by the customer
    COUNT(DISTINCT ro.reward_id) AS total_rewards_earned,

	---counting the days when the customer was active for last date of used .
    DATEDIFF(day, MIN(r.signed_up_on), MAX(r.last_login_date)) AS customer_lifetime_days,

	---calculating the average value reward value for payout and changing the value to decimal of 2
    ISNULL(CAST((SUM(ro.total_payout_in_paise) / 100.0) / COUNT(DISTINCT ro.reward_id) AS DECIMAL(4,2)),0) AS average_reward_value




FROM
	Greedy_game.dbo.['Q2_users signup$'] AS r
	LEFT JOIN Greedy_game.dbo.['Q2_User offer completion data$'] AS d ON r.user_id = d.user_id
	LEFT JOIN Greedy_game.dbo.['Q2_rewards details$'] AS ro ON d.reward_id = ro.reward_id
WHERE 
	r.app_id = 'sikka'
	

GROUP BY
    r.[user_id],
    r.app_id,
	d.user_id
HAVING
	DATEDIFF(day, MIN(r.signed_up_on), MAX(r.last_login_date))<>0







