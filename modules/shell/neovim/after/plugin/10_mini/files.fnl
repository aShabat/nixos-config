(local H {})

(fn toggle-show []
  (set H.show-all (not H.show-all))
  (MiniFiles.refresh MiniFiles.config))

(fn filter-strict [fs-entry] (not (vim.startswith fs-entry.name ".")))

(fn filter [fs-entry] (if H.show-all true (filter-strict fs-entry)))

(local group (vim.api.nvim_create_augroup :minifiles {}))
(vim.api.nvim_create_autocmd :User {:pattern :MiniFilesBufferCreate
                                    :callback (fn [args]
                                                (vim.keymap.set :n :g.
                                                                toggle-show
                                                                {:buffer args.data.buf_id})
                                                (print :test))
                                    : group})

(let [mf (require :mini.files)]
  (mf.setup {:options {:use_as_default_explorer true}
             :content {: filter}
             :windows {:width_preview 100}
             :mappings {:go_in :L :go_in_plus :l}}))

(let [file-explorer (fn []
                      (set H.show-all false)
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
