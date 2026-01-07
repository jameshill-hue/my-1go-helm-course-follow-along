# 1go Helm Masterclass - From Beginner to Advanced

Welcome to the **1go Helm Masterclass** repository! This repository contains all the code, examples, and hands-on exercises from the comprehensive Helm course.

## 📚 Course Information

**Course Name:** 1go Helm Masterclass - From Beginner to Advanced

**Course URL:** [https://learn.go1.com/content/37844164](https://learn.go1.com/content/37844164)

**Original Repository,full course content:** [https://github.com/lm-academy/helm-course](https://github.com/lm-academy/helm-course)

**Notion URL -Created Notes:** [https://www.notion.so/Helm-Learning-1go-26f0da3af7b5804bba97d1104ee2a4c3](https://www.notion.so/Helm-Learning-1go-26f0da3af7b5804bba97d1104ee2a4c3)

## 🎯 About This Course

This masterclass takes you from Helm basics to advanced concepts, covering everything you need to become proficient with Helm, the Kubernetes package manager. You'll learn how to create, manage, and deploy Helm charts effectively.

## 📁 Repository Structure

This repository is organized by course sections, with each folder containing practical examples and exercises:

### `intro-go-templating/`
Introduction to Go templating in Helm charts. Learn the fundamentals of Helm's templating engine.

### `setting-values/`
Learn how to set and override values in Helm charts, including custom values files and configuration management.

### `templating-deep-dive/`
Advanced templating concepts including helpers, functions, complex template patterns, and validation techniques. Includes examples of:
- Template helpers (`_helpers.tpl`)
- Value validation (`validation.yaml`)
- Advanced Go templating functions
- Conditional rendering and control structures

### `creating-charts/`
Hands-on examples of creating complete Helm charts:
- **`backend-app/`**: A full-featured backend application chart with deployments, services, ingress, HPA, HTTPRoute, service accounts, and test templates
- **`nginx/`**: A simple nginx chart demonstrating basic chart structure
- **`nginx-0.1.0.tgz`**: Packaged Helm chart ready for distribution

### `helm-charts/`
Helm chart repository structure for hosting and distributing Helm charts. Includes:
- Chart index (`index.yaml`)
- Packaged charts (`.tgz` files)
- Repository metadata and documentation

### `GitHubPublish/`
Example setup for publishing Helm charts to GitHub Pages or other hosting platforms. Demonstrates how to structure a chart repository for public distribution.

## 🚀 Getting Started

1. **Prerequisites:**
   - Kubernetes cluster (local or remote)
   - Helm 3.x installed
   - Basic understanding of Kubernetes concepts

2. **Install Helm:**
   ```bash
   # macOS
   brew install helm
   
   # Linux
   curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
   ```

3. **Explore the Examples:**
   - Navigate to any folder to see example charts
   - Each chart can be installed and tested in your Kubernetes cluster
   - Review the `values.yaml` files to understand configuration options

4. **Try the Exercises:**
   - Follow along with the course videos
   - Modify the examples to experiment with different configurations
   - Test your understanding by creating your own charts

## 📦 Working with Chart Repositories

This repository includes examples of Helm chart repositories:

- **`helm-charts/`**: A local chart repository structure with packaged charts and index files
- **`GitHubPublish/`**: Example setup for publishing charts to GitHub Pages or other hosting platforms

To use a local chart repository:
```bash
# Add the local repository
helm repo add local-charts file:///path/to/helm-charts

# Update repository index
helm repo update

# Install from local repository
helm install my-release local-charts/nginx
```

## 📖 How to Use This Repository

- **For Learning:** Follow the folder order to progress from basic to advanced concepts
- **For Reference:** Use the examples as templates for your own Helm charts
- **For Practice:** Modify the charts and experiment with different configurations
- **For Distribution:** Explore the `helm-charts/` and `GitHubPublish/` directories to learn how to set up your own Helm chart repository

## 🔗 Additional Resources

- [Helm Official Documentation](https://helm.sh/docs/)
- [Helm Chart Best Practices](https://helm.sh/docs/chart_best_practices/)
- [Go Template Documentation](https://pkg.go.dev/text/template)

## 📝 Notes

This repository is based on the original course materials from [lm-academy/helm-course](https://github.com/lm-academy/helm-course). All examples and exercises are designed to complement the video course content.

---

**Happy Learning!** 🎉

If you have questions or need help, refer to the course materials or the Helm community resources.

