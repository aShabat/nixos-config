(vim.pack.add [{:src "https://github.com/nvim-mini/mini.nvim"}])

(fn setup [package ?opts]
  (let [required (require package)]
    (required.setup (or opts {}))))

(setup :mini.extra)

;; Icons
(setup :mini.icons)
(MiniIcons.mock_nvim_web_devicons)

;; Git
(setup :mini.git)

;; HiPatterns
(setup :mini.hipatterns)
(setup :mini.hipatterns
       {:highlighters {:fixme {:pattern :FIXME :group :MiniHiPatternsFixMe}
                       :hack {:pattern :HACK :group :MiniHiPatternsHack}
                       :todo {:pattern :TODO :group :MiniHiPatternsTodo}
                       :note {:pattern :NOTE :group :MiniHiPatternsNote}
                       :hex-color (MiniHipatterns.gen_highlighter.hex_color)}})

(set vim.opt.cmdheight 0)
(set vim.opt.showcmdloc :statusline)

;; Status Line
(let [active-content (fn []
                       (let [msl MiniStatusline
                             reg-recording (vim.fn.reg_recording)
                             reg-recording (if (not= reg-recording "")
                                               (.. "Recording: @" reg-recording)
                                               reg-recording)
                             [mode mode-hl] [(msl.section_mode {:trunc_width 120})]
                             git (msl.section_git {:trunc_width 40})
                             diff (msl.section_diff {:trunc_width 75})
                             diagnostics (msl.section_diagnostics {:trunc_width 75})
                             lsp (msl.section_lsp {:trunc_width 75})
                             filename (msl.section_filename {:trunc_width 140})
                             fileinfo (msl.section_fileinfo {:trunc_width 120})
                             location (msl.section_location {:trunc_width 75})
                             search (msl.section_searchcount {:trunc_width 75})
                             showcmd (. (vim.api.nvim_eval_statusline "%S" {})
                                        str)]
                         (msl.combine_groups [{:hl :MiniStatuslineDevinfo
                                               :strings [reg-recording]}
                                              {:hl mode-hl :strings [mode]}
                                              {:hl :MiniStatuslineDevinfo
                                               :strings [git
                                                         diff
                                                         diagnostics
                                                         lsp]}
                                              "%<"
                                              {:hl :MiniStatuslineFilename
                                               :strings [filename]}
                                              "%="
                                              {:hl :MiniStatuslineFileinfo
                                               :strings [fileinfo]}
                                              {:hl mode-hl
                                               :strings [search location]}
                                              {:hl :MiniStatuslineDevinfo
                                               :strings [showcmd]}])))]
  (setup :mini.statusline {:content {:active active-content}}))

;; Trailspace
(setup :mini.trailspace)

;; Notify
(setup :mini.notify {:window {:max_width_share 0.7}})
(set vim.notify (MiniNotify.make_notify {}))
(vim.api.nvim_create_user_command :MNHistory
                                  (fn []
                                    (let [editor-width vim.o.columns
                                          editor-height vim.o.lines]
                                      (vim.api.nvim_open_win (vim.api.nvim_create_buf false
                                                                                      true)
                                                             true
                                                             {:relative :editor
                                                              :width (math.floor (* editor-width
                                                                                    0.9))
                                                              :height (math.floor (* editor-height
                                                                                     0.8))
                                                              :row (math.floor (* editor-height
                                                                                  0.05))
                                                              :col (math.floor (* editor-width
                                                                                  0.05))
                                                              :border :single
                                                              :title [["Notification History"
                                                                       :MiniFilesTitle]]}))
                                    (MiniNotify.show_history)
                                    (vim.api.nvim_buf_set_keymap 0 :n :q
                                                                 :<CMD>q<CR> {}))
                                  {})

;; Move
(setup :mini.move {:mappings {:left :H
                              :right :L
                              :up :K
                              :down :J
                              :line_left ""
                              :line_right ""
                              :line_up :<C-k>
                              :line-down :<C-j>}})

;; Splitjoin
(setup :mini.splitjoin)

;; AI
(setup :mini.ai {:custom_textobjects {:G (MiniExtra.gen_ai_spec.buffer)
                                      :L (MiniExtra.gen_ai_spec.line)}
                 :search_method :cover
                 :n_lines math.huge})

;; Bracketed
(setup :mini.bracketed {:diagnostic {:option {:float true}}})

;; Surround
(setup :mini.surround)

{}
