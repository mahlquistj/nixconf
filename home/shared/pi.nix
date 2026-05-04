{pkgs, ...}: let
  pi-dir = ".pi";
in {
  home = {
    packages = with pkgs; [pi-coding-agent];
    file = {
      "${pi-dir}/agent/models.json" = {
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
      "${pi-dir}/agent/settings.json" = {
        force = true;
        text = builtins.toJSON {
          packages = ["npm:context-mode"];
        };
      };
      "${pi-dir}/agent/mcp.json" = {
        force = true;
        text = builtins.toJSON {
          mcpServers = {
            context-mode = {
              command = "context-mode";
            };
          };
        };
      };
    };
  };
}
