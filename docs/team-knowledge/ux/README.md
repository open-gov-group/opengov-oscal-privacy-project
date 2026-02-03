# UX Team Knowledge Base

**Team**: User Experience & Design
**Focus**: User Research, UI Design, Accessibility, Usability Testing
**Last Updated**: 2026-01-28

---

## 📋 Quick Links

- [Design System](design-system.md) - UI components, colors, typography
- [User Research Findings](user-research-findings.md) - Interviews, usability tests
- [Accessibility Checklist](accessibility-checklist.md) - WCAG 2.1 AA requirements
- [Wireframes](wireframes/) - Design mockups and prototypes

---

## 🎯 Team Mission

Create an intuitive, accessible, and delightful user experience that serves both citizens (simple, educational) and DPOs (comprehensive, professional) with equal excellence.

---

## 🏗️ Design Principles

1. **Dual-Audience First**: Every design serves both citizen and DPO modes
2. **Accessibility is Non-Negotiable**: WCAG 2.1 AA minimum, AAA aspirational
3. **Plain Language**: Technical accuracy without jargon (citizen view)
4. **Progressive Disclosure**: Show simple first, reveal complexity on demand
5. **Performance Matters**: Perceived performance = UX quality

---

## 👥 Team Members

| Name | Role | Focus Area |
|------|------|------------|
| [Name] | UX Lead | Research, strategy |
| [Name] | UI Designer | Visual design, design system |
| [Name] | UX Researcher | User testing, personas |

---

## 📚 Essential Reading

**For New Team Members**:
1. [USER_STORIES.md](../../project/USER_STORIES.md) - Personas & user journeys (60 min)
2. [Design System](design-system.md) - UI specifications (45 min)
3. [Accessibility Checklist](accessibility-checklist.md) - A11y requirements (30 min)
4. [Feature Specifications](../../features/) - Technical constraints (60 min)

---

## 🎨 Design System

### Color Palette

**Primary Colors**:
- Blue 600: `#2563EB` (Primary actions, links)
- Blue 50: `#EFF6FF` (Backgrounds, highlights)
- Gray 900: `#111827` (Text primary)
- Gray 600: `#4B5563` (Text secondary)

**Semantic Colors**:
- Green 600: `#059669` (Success)
- Yellow 600: `#D97706` (Warning)
- Red 600: `#DC2626` (Error, High risk)
- Blue 600: `#2563EB` (Info, Moderate risk)

**Accessibility**:
- All text meets 4.5:1 contrast ratio (WCAG AA)
- UI elements meet 3:1 contrast ratio
- Never rely on color alone (use icons + text)

### Typography

**Font Family**: System fonts for performance
```css
font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
```

**Type Scale**:
- Heading 1: 2.25rem (36px), font-weight 700
- Heading 2: 1.875rem (30px), font-weight 700
- Heading 3: 1.5rem (24px), font-weight 600
- Heading 4: 1.25rem (20px), font-weight 600
- Body: 1rem (16px), font-weight 400
- Small: 0.875rem (14px), font-weight 400

### Spacing

**Tailwind Scale**: 4px base unit
- xs: 0.5rem (8px)
- sm: 0.75rem (12px)
- md: 1rem (16px)
- lg: 1.5rem (24px)
- xl: 2rem (32px)

---

## 👤 User Personas

See [USER_STORIES.md](../../project/USER_STORIES.md) for detailed personas.

**Primary Personas**:
1. **Maria** (Concerned Citizen)
   - Goal: Understand how her data is protected
   - Pain Point: Technical language is confusing
   - Design Need: Plain language, educational tooltips

2. **Thomas** (Data Protection Officer)
   - Goal: Conduct comprehensive privacy audit
   - Pain Point: Needs all technical details quickly
   - Design Need: Dense information, advanced filtering

3. **Sarah** (Privacy Advocate)
   - Goal: Compare privacy practices across organizations
   - Pain Point: Needs side-by-side comparison
   - Design Need: Export, print, annotation features (future)

---

## 🧪 Usability Testing

### Testing Protocol

**Frequency**: After every major feature (OSCAL-002, 003, 004, 005)

**Test Plan**:
1. Recruit 5 users per persona
2. Define 3-5 key tasks per feature
3. Conduct moderated remote sessions (30 min each)
4. Measure: Task completion rate, time on task, error rate, satisfaction
5. Document findings in [user-research-findings.md](user-research-findings.md)

**Example Tasks** (OSCAL-002: Citizen View):
- "You want to understand what data the organization collects. Find this information."
- "Switch between the simple and detailed views."
- "Explain what you see in the 'maturity level' indicator."

**Success Metrics**:
- Task completion rate >80%
- Average time on task within 20% of expert time
- SUS score >70 (System Usability Scale)

---

## ♿ Accessibility Guidelines

See [accessibility-checklist.md](accessibility-checklist.md) for full checklist.

**Critical Requirements**:

**Keyboard Navigation**:
- All interactive elements reachable via Tab
- Logical tab order
- Visible focus indicators (2px outline)
- Escape to close modals/dialogs

**Screen Readers**:
- Semantic HTML (<button>, <nav>, <main>, <article>)
- ARIA labels for icon-only buttons
- ARIA live regions for dynamic updates
- Alt text for all meaningful images

**Visual**:
- Text contrast 4.5:1 (AA) or 7:1 (AAA)
- Text resizable to 200% without loss of content
- No color-only indicators (use icons + text)
- Animations can be disabled (prefers-reduced-motion)

**Testing Tools**:
- axe DevTools (automated)
- NVDA (Windows screen reader)
- JAWS (Windows screen reader)
- VoiceOver (macOS/iOS screen reader)

---

## 📐 UI Component Specifications

### ControlCard Component

**Layout**:
```
┌─────────────────────────────────────────┐
│ GOV-01: Data Governance              ⭐ │ ← Header
├─────────────────────────────────────────┤
│ [Overview] [Parts] [Links] [Maturity]  │ ← Tabs
├─────────────────────────────────────────┤
│                                         │
│ Content area with prose, properties,    │ ← Body
│ and structured data                     │
│                                         │
└─────────────────────────────────────────┘
```

**Spacing**: 1rem (16px) padding, 0.5rem (8px) gap between elements
**Border**: 1px solid gray-200, 0.5rem (8px) border-radius
**Shadow**: sm (0 1px 2px rgba(0,0,0,0.05))

See [design-system.md](design-system.md) for all components.

---

## 📊 UX Metrics

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| System Usability Scale (SUS) | >70 | - | 🔄 Testing pending |
| Task Completion Rate | >80% | - | 🔄 Testing pending |
| Average Time on Task | Baseline +20% | - | 🔄 Testing pending |
| Accessibility Issues (Critical) | 0 | 0 | ✅ |
| User Satisfaction | 4/5 stars | - | 🔄 Testing pending |

---

## 🔧 Design Tools

**Design**: Figma (preferred) or Sketch
**Prototyping**: Figma, InVision
**User Testing**: UserTesting.com, Maze
**Analytics**: (To be implemented - Google Analytics, Hotjar)

---

## ✅ Design Review Checklist

Before feature handoff to development:

**Requirements**:
- [ ] User stories reviewed
- [ ] Acceptance criteria defined
- [ ] Technical constraints identified

**Design**:
- [ ] Wireframes created
- [ ] High-fidelity mockups complete
- [ ] Mobile responsive design included
- [ ] Edge cases designed (empty states, errors, loading)

**Accessibility**:
- [ ] Color contrast checked (4.5:1)
- [ ] Keyboard navigation flow defined
- [ ] ARIA labels specified
- [ ] Focus indicators designed

**Documentation**:
- [ ] Design system updated (if new components)
- [ ] Component specs documented
- [ ] Interaction patterns documented

---

## 📞 Communication

**Design Review**: Fridays 3:00 PM
**Usability Testing**: End of sprint (bi-weekly)
**Questions**: #ux-design Slack channel
**Design Critiques**: Wednesdays 4:00 PM (optional)

---

## 🔗 Related Documentation

- [User Stories & Personas](../../project/USER_STORIES.md)
- [Feature Specifications](../../features/)
- [Code Style Guide](../../architecture/CODE_STYLE.md#accessibility)

---

**Last Updated**: 2026-01-28
**Maintained By**: UX Lead
**Questions?** Ask in #ux-design Slack
