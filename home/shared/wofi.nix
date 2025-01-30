{ utils, ... }:
let wofiStyling = utils.import.css ./wofi.css;
in {
  programs.wofi = {
    enable = true;

    settings = {
      key_expand = "End";
      style = "${wofiStyling}";
    };
  };
}
