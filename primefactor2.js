function getPrimeFactor(n) {
  const primeFactors = [];
  const primeIter = genPrimeNumber();

  while (n > 1) {
    const prime = primeIter.next().value;
    if (prime * prime > n) break;
    while (n % prime == 0) {
      primeFactors.push(prime);
      n /= prime;
    }
  }
  if (n > 1) primeFactors.push(n);
  return primeFactors;
}

function* genPrimeNumber() {
  yield 2;
  const primeNumbers = [];
  for (let p = 3;; p += 2) {
    if (primeNumbers.some(d => p % d == 0)) continue;
    yield p;
    primeNumbers.push(p);
  }
}

for (let i = 1; i <= 1000; i++) console.log(getPrimeFactor(i));
