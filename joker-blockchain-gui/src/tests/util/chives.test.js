const joker = require('../../util/joker');

describe('joker', () => {
  it('converts number mojo to joker', () => {
    const result = joker.mojo_to_joker(1000000);

    expect(result).toBe(0.000001);
  });
  it('converts string mojo to joker', () => {
    const result = joker.mojo_to_joker('1000000');

    expect(result).toBe(0.000001);
  });
  it('converts number mojo to joker string', () => {
    const result = joker.mojo_to_joker_string(1000000);

    expect(result).toBe('0.000001');
  });
  it('converts string mojo to joker string', () => {
    const result = joker.mojo_to_joker_string('1000000');

    expect(result).toBe('0.000001');
  });
  it('converts number joker to mojo', () => {
    const result = joker.joker_to_mojo(0.000001);

    expect(result).toBe(1000000);
  });
  it('converts string joker to mojo', () => {
    const result = joker.joker_to_mojo('0.000001');

    expect(result).toBe(1000000);
  });
  it('converts number mojo to colouredcoin', () => {
    const result = joker.mojo_to_colouredcoin(1000000);

    expect(result).toBe(1000);
  });
  it('converts string mojo to colouredcoin', () => {
    const result = joker.mojo_to_colouredcoin('1000000');

    expect(result).toBe(1000);
  });
  it('converts number mojo to colouredcoin string', () => {
    const result = joker.mojo_to_colouredcoin_string(1000000);

    expect(result).toBe('1,000');
  });
  it('converts string mojo to colouredcoin string', () => {
    const result = joker.mojo_to_colouredcoin_string('1000000');

    expect(result).toBe('1,000');
  });
  it('converts number colouredcoin to mojo', () => {
    const result = joker.colouredcoin_to_mojo(1000);

    expect(result).toBe(1000000);
  });
  it('converts string colouredcoin to mojo', () => {
    const result = joker.colouredcoin_to_mojo('1000');

    expect(result).toBe(1000000);
  });
});
