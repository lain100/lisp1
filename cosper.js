function getBestCosper(money, destList) {
  let place = false;
  let cosper = 0;

  destList.forEach(v => {
    if (money >= v[0] && (cosper * v[0] < v[1] || place == false)) {
      place = v[2];
      cosper = v[1] / v[0];
    }
  })
  return place;
}

const destList = [
  [1, 10, 'a'],
  [2, 30, 'b'],
  [1, 30, 'c'],
  [10, 10000, 'd'],
];

[[5, destList], [0, destList], [500000, []]]
 .forEach(v => console.log(getBestCosper(...v)))
