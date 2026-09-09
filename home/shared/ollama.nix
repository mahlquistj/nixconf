{pkgs, ...}: {
  services.ollama = {
    enable = true;
    port = 11434;
    package = pkgs.ollama-rocm; # Ensures AMD ROCm acceleration is active

    environmentVariables = {
      # 1. Sets the global default context length to 128k
      OLLAMA_CONTEXT_LENGTH = "131072";

      # 2. REQUIRED FOR 128K: Compresses context memory so it fits in 16GB VRAM
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q4_0"; # 'q4_0' saves ~75% VRAM; use 'q8_0' for slightly better logic at ~50% savings
    };
  };
}
