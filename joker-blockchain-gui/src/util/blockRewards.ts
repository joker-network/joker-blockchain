import Big from 'big.js';

const MOJO_PER_JOKER = Big(100000000);
const BLOCKS_PER_YEAR = 1681920;

export function calculatePoolReward(height: number): Big {
  if (height === 0) {
    return MOJO_PER_JOKER.times(0);
  }
  if (height < 1 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(2*10*0.9).times(7 / 8);
  }
  if (height < 2 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(1*10*0.9).times(7 / 8);
  }
  if (height < 3 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(0.5*10*0.9).times(7 / 8);
  }
  if (height < 4 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(0.25*10*0.9).times(7 / 8);
  }
  return MOJO_PER_JOKER.times(0.125*10*0.9).times(7 / 8);
}

export function calculateBaseFarmerReward(height: number): Big {
  if (height === 0) {
    return MOJO_PER_JOKER.times(0);
  }
  if (height < 1 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(2*10*0.9).times(1 / 8);
  }
  if (height < 2 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(1*10*0.9).times(1 / 8);
  }
  if (height < 3 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(0.5*10*0.9).times(1 / 8);
  }
  if (height < 4 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(0.25*10*0.9).times(1 / 8);
  }

  return MOJO_PER_JOKER.times(0.125*10*0.9).times(1 / 8);
}


export function calculateBaseCommunityReward(height: number): Big {
  if (height === 0) {
    return MOJO_PER_JOKER.times(0);
  }
  if (height < 1 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(2*10).times(1 / 10);
  }
  if (height < 2 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(1*10).times(1 / 10);
  }
  if (height < 3 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(0.5*10).times(1 / 10);
  }
  if (height < 4 * BLOCKS_PER_YEAR) {
    return MOJO_PER_JOKER.times(0.25*10).times(1 / 10);
  }

  return MOJO_PER_JOKER.times(0.125*10).times(1 / 10);
}
