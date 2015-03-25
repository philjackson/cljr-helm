;;; cljr-helm.el --- Wraps clojure refactor commands with helm -*- coding: utf-8-unix -*-

;; Copyright (C) 2015 Phil Jackson

;; Author   : Phil Jackson <phil@shellarchive.co.uk>
;; URL      : https://github.com/philjackson/cljr-helm
;; Version  : 0.3
;; Keywords : helm, clojure, refactor
;; Package-Requires: ((clj-refactor "0.13.0") (helm "1.5.6"))

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Remembering key bindings for cljr is hard, especially the less
;; frequently used ones - this should help with that.

;; Simply bind `cljr-helm` to a key (I'd suggest C-c C-r) in Clojure
;; mode, and you're ready to go.

(defvar cljr-helm-options
  '(("ad: add declaration" . cljr-add-declaration)
    ("ai: add import to ns" . cljr-add-import-to-ns)
    ("ap: add project dependency" . cljr-add-project-dependency)
    ("am: add missing libspec" . cljr-add-missing-libspec)
    ("ar: add require to ns" . cljr-add-require-to-ns)
    ("au: add use to ns" . cljr-add-use-to-ns)
    ("cn: clean ns" . cljr-clean-ns)
    ("cc: cycle coll" . cljr-cycle-coll)
    ("ci: cycle if" . cljr-cycle-if)
    ("cp: cycle privacy" . cljr-cycle-privacy)
    ("cs: cycle stringlike" . cljr-cycle-stringlike)
    ("ct: cycle thread" . cljr-cycle-thread)
    ("dk: destructure keys" . cljr-destructure-keys)
    ("el: expand let" . cljr-expand-let)
    ("ef: extract function" . cljr-extract-function)
    ("fu: find usages" . cljr-find-usages)
    ("hd: hotload dependency" . cljr-hotload-dependency)
    ("il: introduce let" . cljr-introduce-let)
    ("mf: move form" . cljr-move-form)
    ("ml: move to let" . cljr-move-to-let)
    ("pc: project clean" . cljr-project-clean)
    ("pf: promote function" . cljr-promote-function)
    ("rf: rename file" . cljr-rename-file)
    ("rl: remove let" . cljr-remove-let)
    ("rs: rename symbol" . cljr-rename-symbol)
    ("rr: remove unused requires" . cljr-remove-unused-requires)
    ("ru: replace use" . cljr-replace-use)
    ("sn: sort ns" . cljr-sort-ns)
    ("sp: sort project dependencies" . cljr-sort-project-dependencies)
    ("sr: stop referring" . cljr-stop-referring)
    ("tf: thread first all" . cljr-thread-first-all)
    ("th: thread" . cljr-thread)
    ("tl: thread last all" . cljr-thread-last-all)
    ("ua: unwind all" . cljr-unwind-all)
    ("uw: unwind" . cljr-unwind)
    ("rd: remove debug fns" . cljr-remove-debug-fns)))

(defvar helm-source-cljr
  '((name . "cljr functions")
    (init . (lambda ()
              (helm-init-candidates-in-buffer 'global (mapcar 'car cljr-helm-options))))
    (candidates-in-buffer)
    (persistent-action . ignore)
    (action  . (("Run" . (lambda (candidate)
                           (funcall (cdr (assoc candidate cljr-helm-options)))))))))

;;;###autoload
(defun cljr-helm ()
  (interactive)
  (helm-other-buffer 'helm-source-cljr "*cljr*"))

(provide 'cljr-helm)

;;; cljr-helm.el ends here
