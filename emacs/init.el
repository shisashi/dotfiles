;;;; -*- mode: lisp-interaction; syntax: elisp; coding: euc-jp -*-
;;;;
;;;; emacs ������
;;;;

;; load-path
(add-to-list 'load-path "~/.emacs.d")

;; ����������
; ("����������")
;; 0123456789
; ("0123456789")
;; abcdefghij
; ("abcdefghij")
;; ��������������������
; ("��������������������")

;; ��ݥ��ȥ���ɲ�
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;; system-type predicates
;; from http://d.hatena.ne.jp/tomoya/20090807/1249601308
(setq darwin-p   (eq system-type 'darwin)
      linux-p    (eq system-type 'gnu/linux)
      carbon-p   (eq system-type 'mac)
      meadow-p   (featurep 'meadow))

(if (or darwin-p carbon-p)
    ;; Emacs �� Mac �Υ���åץܡ��ɶ�ͭ
    ;; from http://hakurei-shain.blogspot.com/2010/05/mac.html
    (defun copy-from-osx ()
      (shell-command-to-string "pbpaste"))

  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx))

;; gnuserv
;(require 'gnuserv)
;(gnuserv-start)
;(setq gnuserv-frame (selected-frame)) ; �������ե졼��򳫤��ʤ�

;��������ܸ�ˤ���
(set-language-environment 'Japanese)
; ����UTF-8�Ȥ���
(prefer-coding-system 'utf-8)

(require 'skk-autoloads)
(global-set-key (kbd "C-x C-j") 'skk-mode) ; C-x C-j �� skk �⡼�ɤ�ư
;(setq skk-byte-compile-init-file t) ; .skk ��ưŪ�˥Х��ȥ���ѥ���

; emacs23
(cond ((string-match "^23\." emacs-version)
  (cond (window-system
    ;(set-default-font "Bitstream Vera Sans Mono-15")
    (set-fontset-font (frame-parameter nil 'font)
      'japanese-jisx0208 '("VL Gothic" . "unicode-bmp"))))))

; emacs24
(cond ((string-match "^24\." emacs-version)
  (cond (window-system
          (let* ((size 16)
                 (asciifont "Ricty") ; ASCII fonts
                 (jpfont "Ricty") ; Japanese fonts
                 (h (* size 10))
                 (fontspec (font-spec :family asciifont))
                 (jp-fontspec (font-spec :family jpfont)))
            (set-face-attribute 'default nil :family asciifont :height h)
            (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
            (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
            (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
            (set-fontset-font nil '(#x0080 . #x024F) fontspec) 
            (set-fontset-font nil '(#x0370 . #x03FF) fontspec))
          ))))

;;;
;;; ���Ѥ˴ؤ�������
;;;

; font-lock-mode�ȥơ���
(global-font-lock-mode t)
(load-theme 'solarized-dark t)

; ���߹Ԥ�ϥ��饤�Ȥ���
(defvar nowline-face 'nowline-face)
(make-face 'nowline-face)
(set-face-background 'nowline-face "#181818")

; �б������̤�Ĵ����
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match-face nil :underline "#ffff00")

;;;
;;; grep
;;;
(setq grep-command "lgrep -n -n -Ks -Ps -Os ")
(setq grep-program "lgrep")

;;;
;;; iswitchb
;;;
(load "iswitchb")
;(iswitchb-default-keybindings)
;(resize-minibuffer-mode)
(add-hook 'iswitchb-define-mode-map-hook
          'iswitchb-my-keys)
(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )
;; ������ΥХåե������Ƥ�ɽ������
(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "���򤷤Ƥ��� buffer �� window ��ɽ�����Ƥߤ롣"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

;;; Windows �Τ褦�˥Хåե����ڤ��ؤ���
;(require 'pc-bufsw)
;(pc-bufsw::bind-keys (quote [C-tab]) (quote [C-S-tab]))
;(global-set-key [?\C-,] 'pc-bufsw::lru)
;(global-set-key [?\C-.] 'pc-bufsw::previous)
;;; C-xC-b ��������
;(global-set-key "\C-x\C-b" 'bs-show)

;; ����ǥ�Ȥ�tab��Ȥ�����ưȽ��
;;(require 'indent-tabs-maybe)
;; �ץ����ʤɤ�̵�̤ʥ��ڡ����ʤɤ�Ĵɽ������
;;(load "develock")

;; gz �� Z �Υե������ľ���ɤ߽񤭤���
(auto-compression-mode t)
;; �¹Բ�ǽ�ʥ�����ץȤ���¸����Ȥ��ˡ��¹ԥե饰��Ω�Ƥ�
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
;; ������������Ǥ����
(blink-cursor-mode nil)
;; �ġ���С���ɽ�����ʤ�
;(tool-bar-mode nil)
;; �����ե������ɽ��
;(auto-image-file-mode t)
;; �ޥ����ۥ�����
(mouse-wheel-mode 1)
;; �褽�� window �ˤϥ�������ɽ�����ʤ�
(setq cursor-in-non-selected-windows nil)
;; isearch �� highlight ��ɽ�����᤯
(setq lazy-highlight-initial-delay 0)
;; line-space
(setq-default line-spacing 1)
;; ̵�̤ʶ��Ԥ˵��դ��䤹������
(setq-default indicate-empty-lines t)
;; ��ư���̤�ɽ�����ʤ�
(setq inhibit-splash-screen t)
;; ��������ϣ��Ԥ���
(setq scroll-step 1)
(setq scroll-conservatively 1000)
(setq vertical-centering-font-regexp ".*")
;; �������뤬��Ƭ�ˤ���Ȥ���C-k�ǰ�Ծä�
(setq kill-whole-line t)
;; modeline �˥饤��ʥ�С���ɽ������⡼��
(line-number-mode t)
(column-number-mode t)
;; �ǲ��Ԥǲ��򲡤��Ƥ⿷�����Ԥ�����ʤ��褦�ˤ���
(setq next-line-add-newlines nil)
;; ��������4�ˤ��롣
(setq tab-width 4)
;; ���֤ϻȤ�ʤ������٤ƥ��ڡ�����
(setq-default indent-tabs-mode nil)
;; mode line�˻����ɽ��
(setq display-time-24hr-format t)
(display-time)
;; ��ܥ���ǥڡ����Ȥ���Ȥ��ˡ��ޥ����ΰ��֤ǤϤʤ�����������ΰ��֤˥ڡ�����
(setq mouse-yank-at-point t)
;; frame-title
(setq frame-title-format `("%b %f"))
;; region �˿����Ĥ�
(setq transient-mark-mode t)
;; read-only �� buffer ��Ǥϡ�kill �� copy
(setq kill-read-only-ok t)
;; ���ߤιԤ�Ĵɽ��
(setq hl-line-face 'nowline-face)
(global-hl-line-mode)
;; mouse �����򤹤�ȼ�ưŪ��kill-ring�˥��ԡ�����
(setq mouse-drag-copy-region t)

;;;
;;; dired
;;;
(load "dired-x")
;(load "sorter")
;; r �� dired �β��̤��Խ��Ǥ���褦�ˤʤ�
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;; dired�ǺƵ����ԡ��ȺƵ������ͭ���ˤ���
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
;; �ǥ��쥯�ȥ�����ɽ������
(setq ls-lisp-dirs-first t)
;; Windows �δ�Ϣ�դ��򸵤˥ե�����򳫤���
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map
              "z" 'dired-fiber-find)))
(defun dired-fiber-find ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (start-process "explorer" "diredfiber" "explorer.exe"
                       (unix-to-dos-filename file))
      (start-process "fiber" "diredfiber" "fiber.exe" file))))
;; dired �� "E" �ǳ�����
(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key "E" 'dired-exec-explorer)))
(defun dired-exec-explorer ()
  "In dired, execute Explorer"
  (interactive)
  (explorer (dired-current-directory)))
;(define-process-argument-editing "/explorer\\.exe$"
;  (lambda (x)
;    (general-process-argument-editing-function x nil nil nil)))
(defun explorer (&optional dir)
  (interactive)
  (setq dir (expand-file-name (or dir default-directory)))
  (if (or (not (file-exists-p dir))
          (and (file-exists-p dir)
               (not (file-directory-p dir))))
      (message "%s can't open." dir)
    (setq dir (unix-to-dos-filename dir))
    (let ((w32-start-process-show-window t))
      (apply (function start-process)
             "explorer" nil "explorer.exe" (list (concat "/e,/root," dir))))))

;; �����ѹ������ե�����˿���Ĥ���
(defface face-file-edited-today
  '((((class color)
      (background dark))
     (:foreground "GreenYellow"))
    (((class color)
      (background light))
     (:foreground "magenta"))
    (t
     ())) nil)
(defvar face-file-edited-today
  'face-file-edited-today)
(defun my-dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   (concat "\\(" (format-time-string
                  "%b %e" (current-time))
           "\\|"(format-time-string
                 "%m-%d" (current-time))
           "\\)"
           " [0-9]....") arg t))
(font-lock-add-keywords
 major-mode
 (list
  '(my-dired-today-search . face-file-edited-today)
  ))

;;;
;;; �����Х���ɤ�����
;;;
(keyboard-translate ?\C-h 'backspace)
(define-key ctl-x-map "g" 'goto-line)
(global-set-key "\M-g" 'goto-line)
(global-set-key [f1] 'help-command)
(global-set-key "\e[A" 'previous-line)
(global-set-key "\e[B" 'next-line)
(global-set-key "\e[C" 'forward-char)
(global-set-key "\e[D" 'backward-char)
(global-set-key "\C-u" 'undo)
(global-set-key "\M-r" 'query-replace)
(global-set-key "\M-R" 'replace-string)
(setq-default kinsoku-ascii t)

;; ��̤ξ�� % �򲡤����б������̤˰�ư
;; ����ʳ��ΤȤ��� % ������
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key "%" 'match-paren)

;; ����ǥ�Ȥ��Ƽ��ιԤ˰�ư����
(defun indent-and-next-line ()
  (interactive)
  (indent-according-to-mode)
  (next-line 1))
;;
(define-key global-map "\M-n" 'indent-and-next-line)

;; region �� active �ʤȤ��� Backspace �Ǥ������
(defadvice backward-delete-char-untabify
  (around ys:backward-delete-region activate)
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))

;;;
;;; �Ƽ� programing-mode ������
;;;

;; dynamic abbrev �� \C-o �ǻȤ�
;(setq-default dabbrev-case-fold-search t)
;(define-key global-map "\C-o" 'dabbrev-expand)

(add-hook 'c-mode-common-hook '(lambda ()
                                 (c-set-style "cc-mode")
                                 ;; ����ǥ���̤�����
                                 (setq c-basic-offset 4)
                                 ;; �����Ȥ����ιԤΥ���ǥ����
                                 ;;(setq c-comment-only-line-offset 0)
                                 (c-set-offset 'substatement-open 0)
                                 ;;(c-toggle-hungry-state t)
                                 ;;(setq c-auto-hungry-string t)
                                 ;;(setq c-auto-newline t)
                                 ))

;; python-mode
;(setq load-path (cons "~/elisp/python-mode-1.0" load-path))
;(autoload 'python-mode "python-mode" nil t)
;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;(add-to-list 'auto-mode-alist '("\\.pyw\\'" . python-mode))
;(add-hook 'python-mode-hook
;          '(lambda()
;             (require 'pycomplete)
;             (setq indent-tabs-mode nil)))

;; C/Migemo
;(setq migemo-command "C:/meadow/bin/cmigemo.exe")
;(setq migemo-options '("-q" "--emacs" "-i" "\g"))
;(setq migemo-dictionary "C:/meadow/packages/etc/migemo/migemo-dict")
;(setq migemo-user-dictionary nil)
;(setq migemo-regex-dictionary nil)

;; advanced-compilation-mode
;(load "ac-mode")
;(ac-mode-on)

;(load "htmlize")

(defvar running-on-x (eq window-system 'x))
(autoload 'actionscript-mode "actionscript-mode" "Major mode for actionscript." t)
;; Activate actionscript-mode for any files ending in .as
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))
;; Load our actionscript-mode extensions.
(eval-after-load "actionscript-mode" '(load "as-config"))

; postscript
;(autoload 'ps-mode "jps-mode" "PostScript mode" t)
;(setq auto-mode-alist (append '(("\\.ps$" . ps-mode)) auto-mode-alist))

;;; yahtml-mode
;(setq auto-mode-alist
;      (cons (cons "\\.html$" 'yahtml-mode) auto-mode-alist))
;(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((syntax . elisp) (encoding . utf-8)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
