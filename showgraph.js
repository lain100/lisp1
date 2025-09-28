function showGraph(ary) {
  let classify = Array(11).fill(0);
  ary.forEach((v) => classify[Math.floor(v / 10)]++);
  classify.forEach((v, i) => console.log(`   ${10 * i}`.slice(-4) + '|'.repeat(v)));
}

showGraph([...Array(1000)].map((v, i) => Math.floor(Math.random() * 101)))
