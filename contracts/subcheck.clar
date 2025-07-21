;; SubCheck - Subscription Access Control Contract

(define-constant contract-owner tx-sender)

(define-data-var subscription-fee uint u100000)     ;; 0.1 STX
(define-data-var subscription-length uint u1440)    ;; ~10 days (10-min blocks)

(define-map subscriptions
  { subscriber: principal }
  { expires-at: uint })

;; Update subscription fee (only contract owner)
(define-public (set-fee (fee uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err u100))
    (var-set subscription-fee fee)
    (ok fee)))

;; Update subscription duration in blocks
(define-public (set-length (length uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err u101))
    (var-set subscription-length length)
    (ok length)))

;; Subscribe or extend subscription
(define-public (subscribe)
  (let ((fee (var-get subscription-fee))
        (length (var-get subscription-length))
        (now stacks-block-height)
        (prev-sub (default-to { expires-at: u0 } (map-get? subscriptions { subscriber: tx-sender })))
        (starts-at (if (> (get expires-at prev-sub) now) (get expires-at prev-sub) now))
        (new-expiry (+ starts-at length)))
    (begin
      (try! (stx-transfer? fee tx-sender (as-contract tx-sender)))
      (map-set subscriptions { subscriber: tx-sender } { expires-at: new-expiry })
      (ok { expires-at: new-expiry }))))


;; Check if a user is currently subscribed
(define-read-only (is-subscribed (who principal))
  (ok (> (get expires-at (default-to { expires-at: u0 } (map-get? subscriptions { subscriber: who }))) stacks-block-height)))
