genePassWord = (len = 8) => {
  const tools = "0123456789abcdefghijklmnopqrstuvwxyz";
  let word = "";

  for (let i = 0; i < len; i++) {
    const dice = diceRoll(tools.length) - 1;
    word += tools.substr(dice, 1);
  }

  return word;
};

diceRoll = (diceMax) => {
  return Math.floor(Math.random() * diceMax) + 1;
};

console.log(genePassWord());
