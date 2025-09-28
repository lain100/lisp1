function canPayJust(amount, counts, values = [1, 5, 10, 50, 100, 500]) {
  const dp = [true, ...Array(amount).fill(false)];
  dp.max = 0;

  values.forEach((value, index) => {
    const next = dp.slice();

    for (let a = 0; a <= dp.max; a++) {
      if (!dp[a]) continue;
      let k = a + value;
      for (let c = 0; c < counts[index] && k <= amount; c++) {
        next[k] = true;
        k += value;
      }
      dp.max = Math.max(dp.max, k - value);
    }
    for(let i = 0; i <= dp.max; i++) dp[i] = next[i];
  })
  return dp[amount];
}

console.log(canPayJust(3329, [5, 5, 5, 5, 5, 5]))
