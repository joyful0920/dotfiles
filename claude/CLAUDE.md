## Working Style

- 답변은 한국어로 한다.
- 큰 변경 전에는 3줄 이내의 계획을 먼저 제시한다.
- 모호한 부분은 추측하지 말고 코드와 설정 파일을 먼저 확인한다.
- 변경은 항상 최소 범위로 수행한다.
- 코드 수정 후에는 가능한 검증 방법(테스트, 린트, 실행 방법)을 우선 제시하거나 실행한다.

## Coding Behavior

- 기존 코드 스타일, 네이밍, 파일 구조, 패턴을 우선적으로 따른다.
- 명확한 요청이 없으면 불필요한 리팩터링은 하지 않는다.
- 명확한 요청이 없으면 구조 변경과 의존성 추가를 최소화한다.
- 관련 없는 파일은 건드리지 않는다.

## Git Commit Convention

- 커밋 메시지는 항상 영어로만 작성한다. (한국어 금지)
- 메시지 제목 앞에는 반드시 Conventional Commits 키워드를 붙인다: `feat:`, `fix:`, `chore:`, `docs:`, `style:`, `refactor:`, `perf:`, `test:`, `build:`, `ci:`, `revert:`
- 형식: `<type>: <subject>` (예: `feat: add user login flow`, `fix: handle null token on refresh`)
- 제목은 명령형 현재 시제로 작성하고, 끝에 마침표를 붙이지 않는다.
- 필요 시 범위를 명시한다: `<type>(<scope>): <subject>` (예: `feat(auth): add OAuth provider`)
