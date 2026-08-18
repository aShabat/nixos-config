;nix-pkgs:rustup
(fn build-blink [params]
  (when (= params.spec.name :blink.cmp)
    (vim.notify "Building blink.cmp" vim.log.levels.INFO)
    (let [obj (: (vim.system [:cargo :build :--release] {:cwd params.path})
                 wait)]
      (if (= obj.code 0)
          (vim.notify "Building blink.cmp done" vim.log.levels.INFO)
          (vim.notify "Building blink.cmp failed" vim.log.levels.INFO)))))

(vim.api.nvim_create_autocmd :PackChanged {:callback build-blink})

(vim.pack.add [{:src "https://github.com/saghen/blink.cmp"}])
