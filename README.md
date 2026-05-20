# flutter_poc

A simple Flutter demo application created to showcase multiple Dart and Flutter concepts.

---

# Table of Contents

- [Core Dart & Programming](#core-dart--programming)
    - [Advanced Dart Syntax & Features](#advanced-dart-syntax--features)
    - [Object-Oriented Design in Dart](#object-oriented-design-in-dart)
    - [Generics & Collections](#generics--collections)
    - [Functional Programming in Dart](#functional-programming-in-dart)
    - [Memory & Performance Optimization](#memory--performance-optimization)

- [Asynchronous & Concurrent Programming](#asynchronous--concurrent-programming)
    - [Asynchronous Programming & Isolates](#asynchronous-programming--isolates)
    - [Concurrency & Isolates](#concurrency--isolates)
    - [Concurrency & Multithreading](#concurrency--multithreading)
    - [Custom Widgets & Composition](#custom-widgets--composition)
    - [Animation & Transitions](#animation--transitions)

- [UI Architecture & Advanced Rendering](#ui-architecture--advanced-rendering)
  - [Widget Lifecycle & Rendering](#widget-lifecycle--rendering)
  - [Widget Lifecycle & Rendering Architecture](#widget-lifecycle--rendering-architecture)
  - [Design Patterns in UI](#design-patterns-in-ui)
  - [Responsive UI Design](#responsive-ui-design)
  - [Theme & Styling Architecture](#theme--styling-architecture)
  - [Accessibility & Localization](#accessibility--localization)

- [Navigation & Routing](#navigation--routing)
  - [Navigation & Routing Architecture](#navigation--routing-architecture)

- [State Management](#state-management)
  - [Lifting State Up](#lifting-state-up)
  - [InheritedWidget Basics](#inheritedwidget-basics)
  - [InheritedWidget & Context](#inheritedwidget--context)
  - [InheritedWidget & Context Propagation](#inheritedwidget--context-propagation)
  - [Provider Basics](#provider-basics)
  - [Provider State Management](#provider-state-management)
  - [Bloc/Cubit Advanced Patterns](#bloc-cubit-advanced-patterns)

- [Run Project](#run-project)

---


# Core Dart & Programming

## Advanced Dart Syntax & Features
Implemented:
- Records
- Pattern Matching
- Switch Expressions
- Generic Methods

---

## Object-Oriented Design in Dart
Implemented:
- Abstraction
- Inheritance
- Polymorphism
- Encapsulation

Classes:
- Employee
- Developer
- Manager

---

## Generics & Collections
Implemented:
- Generic Methods
- List
- map()
- where()
- fold()

---

## Functional Programming in Dart
Implemented:
- Declarative Coding
- Pure Collection Operations
- Immutable-style transformations

---

## Memory & Performance Optimization
Implemented:
- dispose()
- ValueNotifier
- ValueListenableBuilder
- const widgets
- RepaintBoundary
- ListView.builder

---

# Asynchronous & Concurrent Programming

## Asynchronous Programming & Isolates
Implemented:
- async / await
- Future
- Stream
- Isolate communication

---

## Concurrency & Isolates
Implemented:
- Background task execution
- Data processing using isolates
- Non-blocking UI operations

---

## Concurrency & Multithreading
Implemented:
- Parallel task execution
- Efficient async handling
- Thread-safe operations

---

## Custom Widgets & Composition
Implemented:
- Reusable widgets
- Widget composition
- Custom UI components

---

## Animation & Transitions
Implemented:
- AnimatedContainer
- Fade & Scale Animations

---

# UI Architecture & Advanced Rendering

## Widget Lifecycle & Rendering
Implemented:
- initState()
- dispose()
- didUpdateWidget()
- Stateful vs Stateless widgets
- Efficient rebuild handling

---

## Widget Lifecycle & Rendering Architecture
Implemented:
- Widget tree rendering
- BuildContext usage
- Render optimization
- Const widget optimization
- Controlled widget rebuilding

---

## Design Patterns in UI
Implemented:
- Widget composition
- Reusable component architecture
- Service layer separation
- Model-driven UI
- Unidirectional data flow
- Scalable folder structure

---

## Responsive UI Design
Implemented:
- LayoutBuilder
- MediaQuery
- Adaptive layouts
- Mobile & Web responsiveness
- Flexible & Expanded widgets

---

## Theme & Styling Architecture
Implemented:
- Centralized theme management
- Light & Dark theme support
- Shared color system
- Reusable styling
- Global theme configuration

---

## Accessibility & Localization
Implemented:
- Multi-language support
- English & Arabic localization
- RTL layout support
- Semantic widgets
- Accessible buttons & text
- Adaptive UI for accessibility
- Theme-aware UI rendering

---

# Navigation & Routing

## Navigation & Routing Architecture
Implemented:
- Named route navigation
- Centralized route management
- Route-based screen navigation
- Decoupled navigation architecture
- Navigation using Navigator.pushNamed()

---

# State Management

## Lifting State Up
Implemented:
- Shared parent-managed state
- State synchronization between widgets
- Callback-based state updates

---

## InheritedWidget Basics
Implemented:
- Global shared state
- Custom InheritedWidget creation
- updateShouldNotify()

---

## InheritedWidget & Context
Implemented:
- BuildContext-based state access
- dependOnInheritedWidgetOfExactType()
- Shared theme access across screens

---

## InheritedWidget & Context Propagation
Implemented:
- Global theme propagation
- Automatic widget rebuilding
- Context-based dependency tracking
- Shared app-wide state updates

---

## Provider Basics
Applied Features:
- ChangeNotifier
- ChangeNotifierProvider
- Consumer
- context.read()
- context.watch()
- notifyListeners()
- Shared App State
- Reactive UI Updates

---

## Provider State Management
Applied Features:
- Counter State Management
- Task Management
- Dynamic List Updates
- Add/Delete/Toggle Operations
- Centralized Business Logic
- Optimized Widget Rebuilds
- UI & Logic Separation

---

## Bloc Cubit Advanced Patterns
Applied Features:
- Cubit State Management
- BlocBuilder
- BlocListener
- BlocConsumer
- MultiBlocProvider
- Loading/Success/Error States
- Reactive Architecture
- State Persistence
- Async State Handling
- Clean Architecture Pattern
- Immutable State Updates

# Run Project

```bash
flutter pub get
flutter run