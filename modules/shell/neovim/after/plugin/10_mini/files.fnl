(local {: split} (require :nfnl.string))
(local {: map} (require :nfnl.core))
(local {: basename : filename} (require :nfnl.fs))

(vim.pack.add [{:src "https://github.com/nvim-mini/mini.nvim"}])
(local group (vim.api.nvim_create_augroup :user-minifiles {}))

(local H {})

(set H.show-all false)
(fn H.toggle-show []
  (set H.show-all (not H.show-all))
  (MiniFiles.refresh MiniFiles.config))

;nix-pkgs:fd
(fn H.filter-fd [fs-entry]
  (let [process (vim.system [:fd
                             :-q
                             :-g
                             (filename fs-entry.path)
                             :-C
                             (basename fs-entry.path)])
        status (. (process:wait 1000) :code)]
    (= status 0)))

(fn H.filter-strict [fs-entry] (not (vim.startswith fs-entry.name ".")))

(fn H.filter [fs-entry] (if H.show-all true (H.filter-fd fs-entry)))

(vim.api.nvim_create_autocmd :User
                             {:pattern :MiniFilesBufferCreate
                              : group
                              :callback (fn [args]
                                          (vim.keymap.set :n :g. H.toggle-show
                                                          {:buffer args.data.buf_id})
                                          (print :test))})

(let [MiniFiles (require :mini.files)]
  (MiniFiles.setup {:options {:use_as_default_explorer true}
                    :content {:filter H.filter}
                    :windows {:width_preview 100}
                    :mappings {:go_in :L :go_in_plus :l}}))

(let [file-explorer (fn []
                      (let [path (vim.api.nvim_buf_get_name 0)
                            path (vim.fs.normalize path)
                            path (if (= (vim.fn.filereadable path) 0)
                                     (let [path (vim.fs.dirname path)]
                                       (if (= (vim.fn.isdirectory path) 0)
                                           (vim.fn.getcwd)
                                           path))
                                     path)]
                        (MiniFiles.open path false)
                        (MiniFiles.trim_right)))]
  (vim.keymap.set :n :<leader>e file-explorer))

{}
