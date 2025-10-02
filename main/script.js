// $().ready(function(){
//   const month   = $('<select name="month">').on('change', changeDay);
//   const day     = $('<select name="day">');
//   const p       = $('<p>').html('here').css('border-style', 'double');
//   const button  = $('<button>').html('decide').on('click', decideDate);
//   [month, day, p, button].forEach((e) => $('body').append(e));
//   initMonth();
//   changeDay();
// });
//
// function decideDate() {
//   const month = $('[name=month]').val();
//   const day   = $('[name=day]').val();
//   $('p').html(`Today's date is ${month} / ${day}`);
// };
//
// function initMonth() {
//   for (let m = 1; m <= 12; m++) {
//     const month = $('<option>').val(m).html(m);
//     $('[name=month]').append(month);
//   }
// };
//
// function changeDay() {
//   $('[name=day]').html('');
//   const month  = $('[name=month]').val();
//   const dayMax = month2day(month);
//
//   for (let d = 1; d <= dayMax; d++) {
//     const day = $('<option>').val(d).html(d);
//     $('[name=day]').append(day);
//   }
// };
//
// function month2day(month) {
//   return month == '2' ? 29 : (['4', '6', '9', '11'].includes(month) ? 31 : 30);
// };

function rand(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

$().ready(function() {
  const audio = new Audio('../mosu-game/QOM/Audio/BGM/トンネル.ogg');
  const button = $('<button>').html('0');
  const img = new Image();
  img.src = '../mosu-game/QOM/Graphics/Pictures/QOM_ミスティア.png';
  Object.assign(audio, {loop: true, volume: 0.8});
  Object.assign(button[0].style, {position: 'fixed', width: '100px', height: '100px'});
  button.on('click', addDice);

  [button, img, audio, $('<p>')].forEach(e => $('body').append(e));
  $('body').css('background-color', 'pink');
})

function addDice() {
  const dice = rand(1, 6);
  const img = $('<img>').attr('src', `../images/${dice}.png`);
  $('button').html(Number($('button').html) + dice);
  img[0].style.width = '10%';
  new Audio('../mosu-game/輝夜ちゃんのおこづかい大作戦/Audio/SE/決定ｷｰ.wav').play();
  $('audio')[0].play();
  if (dice == 6) {
    const audio = new Audio('../mosu-game/QOM/Audio/SE/うますぎる！.ogg');
    audio.volume = 0.4;
    audio.play();
  }
  $('p').append(img);
}
