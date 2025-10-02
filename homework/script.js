$().ready(function(){
  const rewardNumber = generateRandomNumber();
  const boughtNumbers = [...Array(100)].map(() => generateRandomNumber());
  rewardCheck(rewardNumber, boughtNumbers);
  resultSort();
});

function rewardCheck(rewardNumber, boughtNumbers) {
  const total = boughtNumbers.reduce((acc, boughtNumber) => {
    for (const [key, range] of Object.entries([[0], [0, 3], [-1], [0, 0]]))
      if (boughtNumber.slice(...range) == rewardNumber.slice(...range))
        return acc + addLine(boughtNumber, key);
  }, 0);
  $('#reward_number').html(rewardNumber).css('font-size', '300%').css('color', 'red');
  $('#total_reward').html(total).css('font-size', '500%');
};

function generateRandomNumber() {
  return [...Array(3)].reduce(a => a + rand(0, 9), '' + rand(1, 9));
};

function rand(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

function addLine(boughtNumber, rewardType) {
  const {money, color} = [
    {money: '1000000', color: 'red'},
    {money: '10000'  , color: 'green'},
    {money: '300'    , color: 'blue'},
    {money: '0'      , color: 'black'},
  ][rewardType];
  $('[name=result] tbody').append(
    $('<tr>').append($('<td>').html(boughtNumber)).append(
      $('<td>').html(`${money.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')} dollars`)
      .addClass('money').css('font-weight', 'bold').css('color', color)
    )
  );
  return Number(money);
};

function resultSort() {
  const trs = Array.from($('[name=result] tbody tr'));
  trs.sort((a, b) => {
    const nums = [a, b].map(e => $(e).find('.money').html().replace(/\D/g, ''));
    return nums[1] - nums[0];
  });
  $('[name=result] tbody').html('');
  trs.forEach(e => $('[name=result] tbody').append(e));
};
