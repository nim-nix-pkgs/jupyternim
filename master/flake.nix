{
  description = ''A Jupyter Kernel for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-jupyternim-master.flake = false;
  inputs.src-jupyternim-master.ref   = "refs/heads/master";
  inputs.src-jupyternim-master.owner = "stisa";
  inputs.src-jupyternim-master.repo  = "jupyternim";
  inputs.src-jupyternim-master.type  = "github";
  
  inputs."zmq".owner = "nim-nix-pkgs";
  inputs."zmq".ref   = "master";
  inputs."zmq".repo  = "zmq";
  inputs."zmq".dir   = "v1_2_1";
  inputs."zmq".type  = "github";
  inputs."zmq".inputs.nixpkgs.follows = "nixpkgs";
  inputs."zmq".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."hmac".owner = "nim-nix-pkgs";
  inputs."hmac".ref   = "master";
  inputs."hmac".repo  = "hmac";
  inputs."hmac".dir   = "0_2_0";
  inputs."hmac".type  = "github";
  inputs."hmac".inputs.nixpkgs.follows = "nixpkgs";
  inputs."hmac".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."nimsha2".owner = "nim-nix-pkgs";
  inputs."nimsha2".ref   = "master";
  inputs."nimsha2".repo  = "nimsha2";
  inputs."nimsha2".dir   = "master";
  inputs."nimsha2".type  = "github";
  inputs."nimsha2".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimsha2".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."nimpng".owner = "nim-nix-pkgs";
  inputs."nimpng".ref   = "master";
  inputs."nimpng".repo  = "nimpng";
  inputs."nimpng".dir   = "v0_3_2";
  inputs."nimpng".type  = "github";
  inputs."nimpng".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimpng".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-jupyternim-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-jupyternim-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}