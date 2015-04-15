df_last_max_diff <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"
SELECT edible_or_poisonous, cap_color, n, last_value(max_n)
OVER (PARTITION BY edible_or_poisonous ORDER BY n) max_n, last_value(max_n)
OVER (PARTITION BY edible_or_poisonous ORDER BY n) - n n_diff
FROM
(SELECT edible_or_poisonous, cap_color, n, max(n)
OVER (PARTITION BY edible_or_poisonous) max_n 
FROM
(SELECT
CASE
WHEN edible_or_poisonous = \\\'e\\\' THEN \\\'edible\\\'
WHEN edible_or_poisonous = \\\'p\\\' THEN \\\'poisonous\\\'
ELSE edible_or_poisonous END as edible_or_poisonous,
CASE
WHEN cap_color = \\\'b\\\' THEN \\\'buff\\\'
WHEN cap_color = \\\'c\\\' THEN \\\'cinnamon\\\'
WHEN cap_color = \\\'e\\\' THEN \\\'red\\\'
WHEN cap_color = \\\'g\\\' THEN \\\'gray\\\'
WHEN cap_color = \\\'n\\\' THEN \\\'brown\\\'
WHEN cap_color = \\\'p\\\' THEN \\\'pink\\\'
WHEN cap_color = \\\'r\\\' THEN \\\'green\\\'
WHEN cap_color = \\\'u\\\' THEN \\\'purple\\\'
WHEN cap_color = \\\'w\\\' THEN \\\'white\\\'
WHEN cap_color = \\\'y\\\' THEN \\\'yellow\\\'
ELSE cap_color END as cap_color, count(*) n
FROM mushroom GROUP BY edible_or_poisonous, cap_color))
ORDER BY 1,3 DESC
"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_kp8755', PASS='orcl_kp8755', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

tbl_df(df_last_max_diff)
