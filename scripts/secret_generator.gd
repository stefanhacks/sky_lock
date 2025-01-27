class_name SecretGenerator

enum Difficulty {
	VERY_HARD = 1,
	HARD = 2,
	NORMAL = 3,
	EASY = 4,
	VERY_EASY = 5,
}

static func generate_lock_secret(difficulty: Difficulty = Difficulty.NORMAL) -> LockSecret:
	var random_angle = TAU * randf()
	var width_exponent = 2
	var secret = LockSecret.new(random_angle, pow(difficulty, width_exponent) * 2)
	
	return secret
