{ lib, style, ... }:

{
  import = {
    # Function to dynamically replace CSS variables
    css = file:
      let
        # Read the CSS file as a string
        cssContent = lib.fileContents file;

        # Find all occurrences of `var(--<name>)` and replace them dynamically
        dynamicReplace = str:
          let
            # Extract all potential matches for `var(--<name>)` using a basic regex simulation
            matches = lib.splitString "var(--" str;

            # Process each match except the first (since it's the part before the first match)
            processed = lib.concatStringsSep "" (builtins.concatMap (part:
              let
                # Extract the variable name up to the first `)`
                rest = lib.splitString ")" part;
                varName = builtins.head rest;
                remaining = builtins.concatStringsSep ")" (builtins.tail rest);

                # Check if the variable exists in `style` and replace it, otherwise keep it as-is
                replacement = if lib.hasAttr varName style then
                  "#${style.${varName}}"
                else
                  "var(--${varName})";
                # Combine the replacement with the remaining part of the string
              in [ replacement remaining ]) (builtins.tail matches));
            # Reattach the part before the first match
          in builtins.head matches + processed;

        # Apply the replacement
        transformedCss = dynamicReplace cssContent;
      in transformedCss;
  };

  string = {
    removeNewlines = str: builtins.replaceStrings [ "\n" ] [ "" ] str;
  };
}
