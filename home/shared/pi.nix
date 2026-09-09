{pkgs, ...}: let
  pi-dir = ".pi";
in {
  home = {
    packages = with pkgs; [pi-coding-agent];
    sessionVariables = {
      PI_SKIP_VERSION_CHECK = "1";
    };
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
                {
                  id = "batiai/qwen3.5-27b:iq4";
                  capabilities = ["read" "write" "edit" "bash"];
                  tools = true;
                  forceJsonFormat = false;
                  response_format = "text";
                }
                {
                  id = "qwen3.5:9b";
                  capabilities = ["read" "write" "edit" "bash"];
                  tools = true;
                  forceJsonFormat = false;
                  response_format = "text";
                }
              ];
            };
          };
        };
      };
      "${pi-dir}/agent/settings.json" = {
        force = true;
        text = builtins.toJSON {
          packages = ["npm:context-mode" "npm:pi-ask-user"];
          quietStartup = true;
          theme = "dark";
          editorPaddingX = 2;
          defaultProvider = "opencode";
          defaultModel = "big-pickle";
          defaultThinkingLevel = "medium";
          enableInstallTelemetry = false;
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
