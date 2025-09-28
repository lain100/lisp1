function getPriceFactorCount(n) {
  const primeFactors = [];

  genPrimeNumbers(n).forEach((p) => {
    while (n % p == 0) {
      primeFactors.push(p);
      n /= p;
    }
  })
  if (n > 1) primeFactors.push(n);
  return primeFactors.length;
}

function genPrimeNumbers(n) {
  const primeNumbers = [2];
  const sieve = Array(Math.floor(Math.sqrt(n)) + 1).fill(true);

  for (let p = 3; p < sieve.length; p += 2) {
    if (!sieve[p]) continue;
    primeNumbers.push(p);
    for (let i = p * p; i < sieve.length; i += 2 * p) sieve[i] = false;
  }
  return primeNumbers;
}

[...Array(100)].map((v, i) => getPriceFactorCount(i + 1))
.forEach((v, i) => console.log(`   ${i + 1}`.slice(-4) + '|'.repeat(v)))
