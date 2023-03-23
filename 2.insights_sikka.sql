SELECT
	a.[user_id],
	b.app_id,
	COUNT(DISTINCT d.user_id) AS total_offers_initiated,
	COUNT(DISTINCT c.offer_id)  AS total_offers_received,
	COUNT(DISTINCT b.reward_id) AS total_offers_completed,
	ISNULL(SUM(c.total_payout_in_paise)/100.0,0)  AS reward_earned_by_user,
	ISNULL(SUM(c.total_revenue_in_paise)/100.0,0) AS revenue_generated


	

FROM
	Greedy_game.dbo.['Q2_users signup$'] as a
	LEFT JOIN Greedy_game.dbo.['Q2_User offer completion data$'] AS b ON a.user_id=b.user_id
	LEFT JOIN Greedy_game.dbo.['Q2_rewards details$'] AS c ON b.reward_id=c.reward_id
	LEFT JOIN Greedy_game.dbo.['Q2_User offer data$'] AS d ON c.offer_id=d.offer_id
WHERE 
	a.app_id = 'sikka'
GROUP BY
	a.user_id,
	b.user_id,
	b.app_id,
	c.reward_id,
	d.offer_id

HAVING
	COUNT(DISTINCT d.user_id) <>0
	





