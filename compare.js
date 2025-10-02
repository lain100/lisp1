function compareCosper(goto1, goto2, destList) {
  let cospers = [goto1, goto2].map(plase => getCosper(plase, destList));
  if (cospers.includes(false)) return false;
  if (cospers[0] > cospers[1]) return goto1;
  if (cospers[0] < cospers[1]) return goto2;
  return true;
};

function getCosper(plase, destList) {
  for (const d of destList) {
    if (plase == d[2]) return d[1] / d[0];
  }
  return false;
};

const destList = [
  [1, 10, 'a'],
  [1, 30, 'b'],
  [3, 30, 'c'],
  [10, 30000, 'd'],
];

[ ['a', 'b'],
  ['a', 'c'],
  ['a', 'd'],
  ['a', 'e'],
].forEach(v => console.log(compareCosper(...v, destList)));
