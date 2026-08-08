(vim.pack.add [{:src "https://github.com/nvim-mini/mini.nvim"}])

(fn setup [package ?opts]
  (let [required (require package)]
    (required.setup (or opts {}))))

(setup :mini.extra)

(setup :mini.icons)
(MiniIcons.mock_nvim_web_devicons)

(setup :mini.git)

(setup :mini.hipatterns)
(setup :mini.hipatterns
       {:highlighters {:fixme {:pattern :FIXME :group :MiniHiPatternsFixMe}
                       :hack {:pattern :HACK :group :MiniHiPatternsHack}
                       :todo {:pattern :TODO :group :MiniHiPatternsTodo}
                       :note {:pattern :NOTE :group :MiniHiPatternsNote}
                       :hex-color (MiniHipatterns.gen_highlighter.hex_color)}})

(set vim.opt.cmdheight 0)
(set vim.opt.showcmdloc :statusline)

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

(setup :mini.trailspace)

(setup :mini.notify {:window {:max_width_share 0.7}})
(set vim.notify (MiniNotify.make_notify {}))
(vim.api.nvim_create_user_command :MNHistory
                                  (fn [] (MiniNotify.show_history)
                                    (vim.api.nvim_buf_keymap_set 0 :n :q
                                                                 :<CMD>q<CR>)))

(setup :mini.move {:mappings {:left :H
                              :right :L
                              :up :K
                              :down :J
                              :line_left ""
                              :line_right ""
                              :line_up :<C-k>
                              :line-down :<C-j>}})

(setup :mini.splitjoin)

(setup :mini.ai {:custom_textobjects {:G (MiniExtra.gen_ai_spec.buffer)
                                      :L (MiniExtra.gen_ai_spec.line)}
                 :search_method :cover
                 :n_lines math.huge})

(setup :mini.bracketed {:diagnostic {:option {:float true}}})

(setup :mini.surround)

{}
