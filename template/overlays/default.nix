{ self }:
{
  additions = final: prev: import ../pkgs { inherit self; } final.pkgs;
  modifications = final: prev: {
  };
}
