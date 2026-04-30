{...}: let
  pi-dir = ".pi";
in {
  home.file."${pi-dir}/agent/models.json" = {
    force = true;
    text = builtins.toJSON {
      providers = {
        ollama = {
          baseUrl = "http://localhost:11434/v1";
          api = "openai-completions";
          apiKey = "ollama";
          models = [
            {id = "gemma4:26b";}
            {id = "gemma4:e4b";}
          ];
        };
      };
    };
  };
}
